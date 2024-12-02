import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/config.dart';
import '../../auth/presentation/providers/providers.dart';
import 'custom_filled_button.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({
    super.key,
    required this.scaffoldKey,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SideMenuState();
}

class _SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.viewPaddingOf(context).top > 20;
    final textStyles = Theme.of(context).textTheme;
    final auth = ref.watch(authProvider);
    final name = auth.user?.fullName ?? 'Usuario';
    final colors = Theme.of(context).colorScheme;
    final themeMode = ref.watch(themeNotifierProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

    return NavigationDrawer(
      elevation: 1,
      selectedIndex: navDrawerIndex,
      onDestinationSelected: (value) {
        setState(() {
          navDrawerIndex = value;
        });

        // Navegación basada en el índice seleccionado
        switch (value) {
          case 0:
            // Navegar a la pantalla principal o dashboard
            context.push('/');
            break;
          case 1:
            // Navegar a settings
            context.push('/settings');
            break;
        }

        // Cerrar el drawer después de la navegación
        widget.scaffoldKey.currentState?.closeDrawer();
      },
      children: [
        // Header con ícono de persona y nombre de usuario
        Padding(
          padding: EdgeInsets.fromLTRB(16, hasNotch ? 20 : 10, 16, 16),
          child: Column(
            children: [
              // Ícono de persona
              CircleAvatar(
                backgroundColor: colors.primaryContainer,
                radius: 40,
                child: Icon(
                  Icons.person,
                  color: colors.primary,
                  size: 60,
                ),
              ),
              const SizedBox(height: 10),
              // Nombre de usuario
              Text(
                name,
                style: textStyles.titleMedium,
              ),
            ],
          ),
        ),

        // Divider
        const Divider(),

        // Destinos de navegación
        NavigationDrawerDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: Text(
            'Inicio',
            style: textStyles.bodyMedium,
          ),
        ),
        NavigationDrawerDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: Text(
            'Configuración',
            style: textStyles.bodyMedium,
          ),
        ),

        // Otro Divider
        const Divider(),

        // Cambiar Tema
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isDarkMode
                  ? Pulse(
                      animate: true,
                      key: Key('$isDarkMode+1'),
                      duration: Duration(milliseconds: 500),
                      child: Icon(
                        Icons.nightlight_round,
                        color: colors
                            .onSurface, // Use the theme's onSurface color for contrast
                      ),
                    )
                  : Spin(
                      animate: true,
                      key: Key(isDarkMode.toString()),
                      duration: Duration(milliseconds: 500),
                      child: Icon(Icons.wb_sunny, color: colors.onSurface)),
              const SizedBox(width: 10),
              // Switch para cambiar el tema
              Switch(
                value: themeMode == ThemeMode.dark,
                onChanged: (_) {
                  // Alternar tema usando el notifier
                  ref.read(themeNotifierProvider.notifier).toggleTheme();
                },
                activeColor: colors.primary,
              ),
            ],
          ),
        ),

        // Otro Divider
        const Divider(),

        // Botón de Cerrar Sesión
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: CustomFilledButton(
            onPressed: ref.read(authProvider.notifier).logout,
            text: 'Cerrar sesión',
          ),
        ),
      ],
    );
  }
}
