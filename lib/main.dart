import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

import 'config/config.dart';
import 'features/shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print('Flutter Version: ${defaultTargetPlatform.toString()}');
  // O más específicamente para versión y motor:
  print('Version: ${Platform.version}');

  await EnvironmentConfig.initialize();

  await Supabase.initialize(
    url: EnvironmentConfig.supabaseUrl,
    anonKey: EnvironmentConfig.supabaseAnonKey,
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
