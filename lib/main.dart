import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    // Observar cambios en el tema
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode, // Usar el tema actual
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('he', ''),
        Locale('es', ''),
        Locale('ru', ''),
        Locale('ko', ''),
        Locale('hi', ''),
      ],
    );
  }
}
