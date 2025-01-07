import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config/config.dart';
import 'features/shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EnvironmentConfig.initialize();

  await Supabase.initialize(
    url: EnvironmentConfig().supabaseUrl,
    anonKey: EnvironmentConfig().supabaseAnonKey,
  );

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
    final seedColor = ref.watch(colorPreferencesProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppThemes.lightTheme(seedColor),
      darkTheme: AppThemes.darkTheme(seedColor),
      themeMode: themeMode, // Usar el tema actual
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
    );
  }
}
