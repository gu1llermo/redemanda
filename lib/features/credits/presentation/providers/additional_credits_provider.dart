import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../auth/presentation/providers/providers.dart';

part 'additional_credits_provider.g.dart';

@Riverpod(dependencies: [supabaseClient])
class AdditionalCredits extends _$AdditionalCredits {
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
        .select('additional_credits')
        .eq('id', userId)
        .single();

    yield initialData['additional_credits'];

    // Crear un StreamController para manejar las actualizaciones
    final controller = StreamController<int>();

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
            final newCredits = payload.newRecord['additional_credits'] as int;
            controller.add(newCredits);
          },
        );

    // Suscribirse al canal
    _subscription?.subscribe();

    // Yield* para emitir valores del StreamController
    yield* controller.stream;
  }
}
