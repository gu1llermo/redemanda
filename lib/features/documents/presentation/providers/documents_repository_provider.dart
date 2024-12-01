import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/providers.dart';
import '../../domain/domain.dart';
import '../../infrastructure/infrastructure.dart';

final documentsRepositoryProvider = Provider<DocumentsRepository>((ref) {
  final accesToken = ref.watch(authProvider).user?.token ?? '';
  final datasource = DocumentsDatasourceImpl(accesToken: accesToken);
  return DocumentsRepositoryImpl(datasource);
});
