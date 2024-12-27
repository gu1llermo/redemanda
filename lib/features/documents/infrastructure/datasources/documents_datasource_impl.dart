import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/config.dart';
import '../../../auth/infrastructure/infrastructure.dart';
import '../../domain/domain.dart';
import '../infrastructure.dart';

class DocumentsDatasourceImpl extends DocumentsDatasource {
  late final Dio dio;
  final String accesToken;
  final String nameDb = 'documents.db';
  final String nameStore = 'documents_sembast_store';
  late StoreRef<int, Map<String, Object?>> _store;
  bool openDatabaseFromMemory = false;
  Database? _database;
  final SupabaseClient supabase;

  DocumentsDatasourceImpl({required this.accesToken, required this.supabase}) {
    dio = Dio(BaseOptions(baseUrl: EnvironmentConfig.supabaseUrl, headers: {
      'Authorization': 'Bearer $accesToken',
    }));
    _store = intMapStoreFactory.store(nameStore);
  }

  Future<Database> get database async => _database ??= await _createDatabase();

  Future<Database> _createDatabase() async {
    final fileName = nameDb;

    if (openDatabaseFromMemory) {
      return await databaseFactoryMemory.openDatabase(fileName);
    }

    if (kIsWeb) {
      return await databaseFactoryWeb.openDatabase(fileName);
    }

    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final path = join(dir.path, fileName);
    return await databaseFactoryIo.openDatabase(path);
  }

  @override
  Future<Document> createDocument(Map<String, dynamic> documentRequest) async {
    try {
      // Call Supabase Edge Function to generate document
      final response = await dio.post(
        '/functions/v1/generate-document',
        data: documentRequest,
      );

      if (response.statusCode != 200) {
        throw CustomError(
            'Error generando el documento: ${response.statusMessage}');
      }

      // Extract base64 document from response
      final base64Doc = response.data['docxBase64'] as String;

      // Convert base64 to Uint8List
      final docxFile = Uint8List.fromList(base64Decode(base64Doc));

      // Get document data from the request
      final data = documentRequest['data'] as Map<String, dynamic>;

      // Create new Document instance
      final newDocument = Document(
        title: data['nombre_demandante'] ?? 'Sin título',
        description: data['nombre_demandado'] ?? 'Sin descripción',
        sizeInBytes: docxFile.length,
        createdAt: DateTime.now(),
        docxFile: docxFile,
        author: supabase.auth.currentUser?.email,
      );

      // Save document to local database
      return await saveDocument(newDocument);
    } catch (e) {
      throw CustomError('Error createDocument: $e');
    }
  }

  Future<Document> saveDocument(Document document) async {
    try {
      final db = await database;

      // Convert the document to a map for storage
      final documentMap = DocumentMapper.entityToJson(document);

      final key = document.id;
      Document? documentCopy;

      await db.transaction((txn) async {
        if (key != null) {
          // update
          await _store.record(key).put(txn, documentMap);
        } else {
          // add new document
          final newId = await _store.add(txn, documentMap);
          documentMap['id'] = newId;

          documentCopy = document.copyWith(id: newId);

          await _store.record(newId).put(txn, documentMap);
        }
      });

      return documentCopy ?? document;
    } catch (e) {
      debugPrint('Error saveDocuments: $e');
      throw CustomError('Error saveDocuments: $e');
    }
  }

  @override
  Future<void> deleteDocument(int id) async {
    try {
      final db = await database;
      await _store.record(id).delete(db);
    } catch (e) {
      throw CustomError('Error deleteDocument: $e');
    }
  }

  @override
  Future<Document> getDocumentById(int id) async {
    try {
      final db = await database;
      final mapRecord = await _store.record(id).get(db);
      // supongo que si no lo consigue regresa null
      if (mapRecord == null) {
        throw CustomError('Document not found');
      }
      return DocumentMapper.jsonToEntity(mapRecord);
    } catch (e) {
      //debugPrint('Error getting document by ID: $e');
      throw CustomError('Error getting document by ID: $e');
    }
  }

  @override
  Future<List<Document>> searchDocumentByTerm(String term) async {
    term = term.trim();
    if (term.isEmpty) return [];
    try {
      final db = await database;

      final finder = Finder(
        filter: Filter.or([
          Filter.custom((record) {
            final title = record['title'] as String? ?? '';

            final searchTerm = term;

            return StringUtils.searchFlexible(title, searchTerm);
          }),
        ]),
        sortOrders: [SortOrder('createdAt', false)],
      );

      final recordSnapshots = await _store.find(
        db,
        finder: finder,
      );

      // Convert record snapshots to Document objects
      return recordSnapshots
          .map((snapshot) => DocumentMapper.jsonToEntity(snapshot.value))
          .toList();
    } catch (e) {
      throw CustomError('Error searching documents: $e');
    }
  }

  @override
  Future<List<Document>> searchDocumentByDateRange(
      {required DateTime startDate, required DateTime endDate}) async {
    try {
      final db = await database;
      final finder = Finder(
          filter: Filter.and([
        Filter.greaterThanOrEquals('createdAt', startDate),
        Filter.lessThanOrEquals('createdAt', endDate)
      ]));

      // final finder = Finder(
      //   filter: Filter.or([
      //     Filter.custom((record) {
      //       final createdAt = DateTime.parse(record['createdAt'] as String);

      //       final compareWithStartDate = createdAt.compareTo(startDate);
      //       final compareWithEndDate = createdAt.compareTo(endDate);
      //       final isAfterOrAtSameMomentAs = compareWithStartDate >= 0;
      //       final isBeforeOrAtSameMomentAs = compareWithEndDate <= 0;

      //       return isAfterOrAtSameMomentAs && isBeforeOrAtSameMomentAs;
      //     }),
      //   ]),
      //   sortOrders: [SortOrder('createdAt', false)],
      // );

      final recordSnapshots = await _store.find(
        db,
        finder: finder,
      );

      recordSnapshots.sort((a, b) => (a.value['createdAt'] as DateTime)
          .compareTo(b.value['createdAt'] as DateTime));

      // Convert record snapshots to Document objects
      return recordSnapshots
          .map((snapshot) => DocumentMapper.jsonToEntity(snapshot.value))
          .toList();
    } catch (e) {
      throw CustomError('Error searchDocumentByRange: $e');
    }
  }

  @override
  Future<List<Document>> getAllDocuments() async {
    try {
      final db = await database;

      final snapshots = await _store.query().getSnapshots(db);
      final listDocuments = snapshots
          .map((snapshot) => DocumentMapper.jsonToEntity(snapshot.value))
          .toList();
      listDocuments
          .sort((doc1, doc2) => doc1.createdAt.compareTo(doc2.createdAt));
      return listDocuments;
    } catch (e) {
      throw CustomError('Error getAllDocuments: $e');
    }
  }

  @override
  Future<List<Document>> getDocumentsPaginated(
      {required int page, required int pageSize, required int offset}) async {
    final db = await database;
    final finder = Finder(
      limit: pageSize,
      offset: offset,
      sortOrders: [SortOrder('createdAt', false)],
    );
    final snapshots = await _store.find(db, finder: finder);
    return snapshots
        .map((snapshot) => DocumentMapper.jsonToEntity(snapshot.value))
        .toList();
  }
}
