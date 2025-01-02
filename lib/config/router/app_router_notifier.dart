import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/providers/providers.dart';

//* Esto lo hace Fernando por un truco para poder refrescar el appRouter y poder
//* usar su redirect, y así poder redireccionar correctamente al usuario
//* dependiendo de si está autenticado ó no

final goRouterNotifierProvider =
    Provider<GoRouterNotifier>((ref) => GoRouterNotifier(ref));

class GoRouterNotifier extends ChangeNotifier {
  final Ref _ref;
  late final ProviderSubscription<AuthStateApp> _subscription;
  // AuthStatus _authStatus = AuthStatus.checking;
  AuthStateApp _authState = AuthStateApp(authStatus: AuthStatus.checking);

  GoRouterNotifier(this._ref) {
    _subscription = _ref.listen(
      authProvider,
      (previous, next) {
        // authState = next.copyWith(
        //   authStatus: next.authStatus,
        //   errorMessage: next.errorMessage,
        //   user: next.user,
        // );
        authState = next;
        // authStatus = next.authStatus;
      },
    );
  }

  AuthStateApp get authState => _authState;
  // AuthStatus get authStatus => _authStatus;

  // set authStatus(AuthStatus value) {
  //   _authStatus = value;
  //   notifyListeners();
  // }

  set authState(AuthStateApp value) {
    _authState = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
