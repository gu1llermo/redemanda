import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/providers.dart';

final documentsRepositoryProvider = Provider<ProductsRepository>((ref) {
  final accesToken = ref.watch(authProvider).user?.token ?? '';
  final datasource = DocumentsDatasourceImpl(accesToken: accesToken);
  return DocumentsRepositoryImpl(datasource);
});
