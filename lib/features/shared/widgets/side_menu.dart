import 'package:animated_toggle_switch/animated_toggle_switch.dart';
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

        const Divider(),

        // Cambiar Tema
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // _ColorPicker(),
              _ChangeModeCustomSwitch(isDarkMode),
            ],
          ),
        ),

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

class _ChangeModeCustomSwitch extends ConsumerWidget {
  const _ChangeModeCustomSwitch(this.isDarkMode);
  final bool isDarkMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return AnimatedToggleSwitch<bool>.dual(
      current: isDarkMode,
      first: false,
      second: true,
      spacing: 30.0,
      borderWidth: 2.0,
      // style: ToggleStyle(
      //   borderColor: Colors.transparent,
      // ),
      height: 40,
      onChanged: (_) {
        ref.read(themeNotifierProvider.notifier).toggleTheme();
      },
      styleBuilder: (value) => ToggleStyle(
        // Usa colores con buen contraste del esquema de colores
        backgroundColor:
            value ? colors.onInverseSurface : colors.primary.withOpacity(0.1),

        indicatorColor: value
            ? colors.onSurfaceVariant // Indicador en modo oscuro
            : colors.surface, // Indicador en modo claro

        borderRadius: const BorderRadius.horizontal(
            left: Radius.circular(50.0), right: Radius.circular(50.0)),
        indicatorBorderRadius: BorderRadius.circular(50),
      ),
      iconBuilder: (value) => Icon(
        value ? Icons.nightlight_round : Icons.wb_sunny,
        size: 32.0,
        color: value
            ? colors.inversePrimary // Alternativa para modo oscuro
            : colors.primary, // Alternativa para modo claro
      ),
      textBuilder: (value) => Center(
        child: Text(
          value ? 'Claro' : 'Obscuro',
          // style: TextStyle(
          //   color: value
          //       ? colors.onSurfaceVariant // Color texto en modo oscuro
          //       : colors.surface, // Color texto en modo claro
          // ),
        ),
      ),
    );
  }
}
