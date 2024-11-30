import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast/sembast_memory.dart';
import 'package:sembast_web/sembast_web.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../../../config/config.dart';
import '../../domain/domain.dart';

class DocumentsDatasourceImpl extends DocumentsDatasource {
  late final Dio dio;
  final String accesToken;
  final String nameDb = 'documents.db';
  final String nameStore = 'documents_sembast_store';
  late StoreRef<int, Map<String, Object?>> _store;
  bool openDatabaseFromMemory = false;
  late Database database;

  DocumentsDatasourceImpl({required this.accesToken}) {
    dio = Dio(BaseOptions(baseUrl: EnvironmentConfig.supabaseUrl, headers: {
      'Authorization': 'Bearer $accesToken',
    }));
    _store = intMapStoreFactory.store(nameStore);
    Future.microtask(_initializeDatabase);
  }

  Future<void> _initializeDatabase() async {
    final fileName = nameDb;

    if (openDatabaseFromMemory) {
      database = await databaseFactoryMemory.openDatabase(fileName);
    }

    if (kIsWeb) {
      database = await databaseFactoryWeb.openDatabase(fileName);
    }

    final dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    final path = join(dir.path, fileName);
    database = await databaseFactoryIo.openDatabase(path);
  }

  @override
  Future<Document> createDocument(Map<String, dynamic> documentData) {
    // TODO: implement createDocument
    throw UnimplementedError();
    // todo: cuando el recibe el dpcumento aquí mismo lo guardo en la base de datos local
  }

  Future<void> saveDocument(Document document) async {}

  @override
  Future<void> deleteDocument(String id) {
    // TODO: implement deleteDocument
    throw UnimplementedError();
  }

  @override
  Future<Document> getDocumentById(String id) {
    // TODO: implement getDocumentById
    throw UnimplementedError();
  }

  @override
  Future<List<Document>> searchDocumentByTerm(String term) {
    // TODO: implement searchDocumentByTerm
    throw UnimplementedError();
  }
}
