import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/providers.dart';

class ResetPasswordScreen extends ConsumerWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final form = ref.watch(resetPasswordFormProvider);

    ref.listen(resetPasswordFormProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        AppErrorsUtils.onError(context, next.errorMessage);
        return;
      }

      // Agregamos esta nueva escucha para la navegación
      if (next.shouldNavigateToLogin) {
        context.go('/login');
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Contraseña')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!form.success) ...[
              CustomTextFormField(
                label: 'Nueva contraseña',
                onChanged: ref
                    .read(resetPasswordFormProvider.notifier)
                    .onPasswordChange,
                errorMessage: form.password.errorMessage,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                label: 'Confirmar contraseña',
                onChanged: ref
                    .read(resetPasswordFormProvider.notifier)
                    .onConfirmPasswordChange,
                errorMessage: form.confirmPassword.errorMessage,
                obscureText: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: CustomFilledButton(
                  text: 'Cambiar contraseña',
                  onPressed: !form.isValid || form.isPosting
                      ? null
                      : ref.read(resetPasswordFormProvider.notifier).onSubmit,
                  buttonColor: colors.primary,
                ),
              ),
            ] else ...[
              const Icon(Icons.check_circle_outline,
                  size: 100, color: Colors.green),
              const SizedBox(height: 20),
              Text(
                'Contraseña actualizada exitosamente',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Serás redirigido al login en unos segundos...',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
