import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/providers.dart';
import '../providers/providers.dart';

class UserCreditsWidget extends ConsumerWidget {
  const UserCreditsWidget({super.key});

  void _showCreditsDialog(BuildContext context, WidgetRef ref, String userId) {
    showDialog(
      context: context,
      barrierDismissible: true, // Permite cerrar al hacer clic fuera
      builder: (BuildContext context) {
        return Consumer(
          builder: (context, ref, child) {
            final fixedCredits = ref.watch(fixedCreditsProvider(userId));
            final additionalCredits =
                ref.watch(additionalCreditsProvider(userId));
            final fixedCreditsValue = fixedCredits.value ?? 0;
            final additionalCreditsValue = additionalCredits.value ?? 0;
            final total = fixedCreditsValue + additionalCreditsValue;

            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.stars,
                    color: Colors.amber.shade600,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$total Crédito${total != 1 ? 's' : ''}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(),
                  const SizedBox(height: 16),
                  fixedCredits.when(
                    data: (fixed) => _buildCreditRow(
                      Icons.account_balance_wallet,
                      Colors.green.shade600,
                      '$fixed crédito${fixed != 1 ? 's' : ''} restantes',
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Icon(Icons.error),
                  ),
                  const SizedBox(height: 16),
                  additionalCredits.when(
                    data: (additional) => _buildCreditRow(
                      Icons.card_giftcard,
                      Colors.purple.shade600,
                      '$additional crédito${additional != 1 ? 's' : ''} adicional${additional != 1 ? 'es' : ''}',
                    ),
                    loading: () => const CircularProgressIndicator(),
                    error: (_, __) => const Icon(Icons.error),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildCreditRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

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
        return IconButton(
          tooltip: creditsTxt,
          icon: Row(
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
          onPressed: () => _showCreditsDialog(context, ref, userId),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (error, stack) => const Icon(Icons.error),
    );
  }
}
