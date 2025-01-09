import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/presentation/providers/providers.dart';

part 'user_credits_provider.g.dart';

@Riverpod(dependencies: [supabaseClient])
class UserCredits extends _$UserCredits {
  RealtimeChannel? _subscription;

  @override
  Stream<int> build(String userId) async* {
    final supabase = ref.watch(supabaseClientProvider);

    ref.onDispose(
      () {
        _subscription?.unsubscribe();
      },
    );

    // Emitir valor inicial
    final initialData = await supabase
        .from('users')
        .select('fixed_credits, additional_credits')
        .eq('id', userId)
        .single();

    final totalInitialCredits = (initialData['fixed_credits'] as int) +
        (initialData['additional_credits'] as int);

    yield totalInitialCredits;

    // Crear un StreamController para manejar las actualizaciones
    final controller = StreamController<int>.broadcast();

    // Configurar suscripción en tiempo real
    _subscription = supabase.channel('public:users').onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: 'users',
          filter: PostgresChangeFilter(
            type: PostgresChangeFilterType.eq,
            column: 'id',
            value: userId,
          ),
          callback: (payload) {
            final newFixedCredits = payload.newRecord['fixed_credits'] as int;
            final newAdditionalCredits =
                payload.newRecord['additional_credits'] as int;
            final totalCredits = newFixedCredits + newAdditionalCredits;
            controller.add(totalCredits);
          },
        );

    // Suscribirse al canal
    _subscription?.subscribe();

    // Yield* para emitir valores del StreamController
    yield* controller.stream;
  }
}
