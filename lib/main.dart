import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';
import 'features/auth/infrastructure/datasources/supabase_auth_datasource_impl.dart';
import 'features/shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EnvironmentConfig.initialize();

  await SupabaseAuthDatasourceImpl.initialize();

  await AppDesktopServiceImpl().config();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme().getLightTheme(),
    );
  }
}
