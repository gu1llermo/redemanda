import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/providers.dart';
import '../../features/auth/presentation/screens/screens.dart';
import '../../features/documents/documents.dart';
import 'app_router_notifier.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  //* El objetivo de encerrar el goRouter con un provider, es para saber si el usuario está autenticado
  //* ó no, es para proteger las rutas, especialmente en la web, en donde un usuario puede llegar
  //* a una parte especifica del programa sin estar autenticado
  //* ESTO SE LLAMA PROTECCIÓN DE RUTAS
  final goRouterNotifier = ref.read(goRouterNotifierProvider);
  return GoRouter(
    // initialLocation: '/reset-password',
    initialLocation: '/splash',
    refreshListenable: goRouterNotifier,
    routes: [
      //* Primera Pantalla
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckOutStatusScreen(),
      ),

      ///* Auth Routes
      GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'recuperar-password',
              builder: (context, state) => const PasswordRecoveryScreen(),
            ),
          ]),

      ///* Documents Routes
      GoRoute(
        path: '/',
        builder: (context, state) => const DocumentsScreen(),
        routes: [
          GoRoute(
            path: NewDocument01Screen.path,
            builder: (context, state) => NewDocument01Screen(),
          ),
          GoRoute(
            path: NewDocument02Screen.path,
            builder: (context, state) => NewDocument02Screen(),
          ),
          GoRoute(
            path: NewDocument03Screen.path,
            builder: (context, state) => NewDocument03Screen(),
          ),
          GoRoute(
            path: NewDocument04Screen.path,
            builder: (context, state) => NewDocument04Screen(),
          ),
          GoRoute(
            path: NewDocument05Screen.path,
            builder: (context, state) => NewDocument05Screen(),
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const UnderConstructionScreen(),
      ),
      GoRoute(
        path: '/admin-settings',
        builder: (context, state) => const UnderConstructionScreen(),
      ),

      ///* Admin Routes
      GoRoute(
        path: '/home-admin',
        builder: (context, state) => const HomeAdminScreen(),
      ),

      ///*

      GoRoute(
        path: '/reset-password',
        builder: (context, state) {
          //final code = state.uri.queryParameters['code'];
          // Puedes pasar el código como parámetro si lo necesitas
          return const ResetPasswordScreen();
        },
      ),
    ],
    redirect: (context, state) {
      // con esto se validan todas las rutas, porque todas pasan por aqui
      final isGoingTo = state.matchedLocation;
      final authState = goRouterNotifier.authState;
      final authStatus = authState.authStatus;
      final isAdmin = authState.user?.isAdmin ?? false;
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null; // lo deja tranquilo que vaya a splash
      }
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/login/recuperar-password' ||
            isGoingTo == '/reset-password') {
          // cuando se coloca null, es para dejar que vaya a la pantalla que quiera
          return null;
        }
        // lo redigirimos al login porque no está autenticado
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        // es importante hacer éstas comprobaciones, porque el usuario es posible que llegue
        // por un deep link
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          // lo mandamos a la ruta principal, porque ya está autenticado
          return '/';
        }
        if (isGoingTo == '/settings') {
          return isAdmin ? '/admin-settings' : null;
        }
        if (isGoingTo == '/admin-settings') {
          return !isAdmin ? '/settings' : null;
        }
      }
      //! Aquí podríamos verificar si el usuario es admin y redirigirlo a una ruta específica
      // final auth = ref.read(authProvider);
      // if (auth.user?.isAdmin ?? false) {
      //   // y hacemos las consideraciones necesarias para redirigir al usuario
      //   // a determinadas pantallas
      // }
      //* También dice que podemos determinar qué página era la que se encontraba mediante argumentos
      //* y almacenarlos, porque puede ser que la persona quiera regresar

      return null;
    },
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
