// credits_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/providers.dart';
import '../providers/providers.dart';

class UserCreditsWidget extends ConsumerWidget {
  const UserCreditsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).user?.id;
    if (userId == null) {
      return const SizedBox.shrink();
    }
    final creditsAsync = ref.watch(userCreditsProvider(userId));

    return creditsAsync.when(
      data: (credits) {
        final creditsTxt = '$credits crédito${credits != 1 ? 's' : ''}';
        return Tooltip(
          message: creditsTxt,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.stars,
                color:
                    credits <= 0 ? Colors.red.shade700 : Colors.amber.shade600,
              ),
              const SizedBox(width: 4),
              Text(
                creditsTxt,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => const Icon(Icons.error),
    );
  }
}
