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
  late final ProviderSubscription<AuthState> _subscription;
  AuthStatus _authStatus = AuthStatus.checking;

  GoRouterNotifier(this._ref) {
    _subscription = _ref.listen(
      authProvider,
      (previous, next) {
        authStatus = next.authStatus;
      },
    );
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
