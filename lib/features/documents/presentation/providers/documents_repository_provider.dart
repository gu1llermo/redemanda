import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

part 'documents_repository_provider.g.dart';

@Riverpod(dependencies: [Auth])
DocumentsRepository documentsRepository(Ref ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';
  final datasource = DocumentsDatasourceImpl(accesToken: accessToken);
  return DocumentsRepositoryImpl(datasource);
}
