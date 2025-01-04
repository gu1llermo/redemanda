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
    final obscureText = form.obscureText;

    ref.listen(resetPasswordFormProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        AppErrorsUtils.onError(context, next.errorMessage);
        return;
      }

      // Agregamos esta nueva escucha para la navegación
      if (next.shouldNavigateToLogin) {
        // Limpiar el historial y navegar al login
        context.go('/login', extra: {'clearHistory': true});
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Contraseña')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!form.success) ...[
                  CustomTextFormField(
                    label: 'Nueva contraseña',
                    prefixIcon: Icon(Icons.password, color: colors.primary),
                    suffixIcon: PasswordSuffixIcon(
                      obscureText: obscureText,
                      onTap: ref
                          .read(resetPasswordFormProvider.notifier)
                          .onTapPasswordSuffixIcon,
                    ),
                    onChanged: ref
                        .read(resetPasswordFormProvider.notifier)
                        .onPasswordChange,
                    errorMessage:
                        form.isFormPosted ? form.password.errorMessage : null,
                    obscureText: obscureText,
                  ),
                  //**** */
                  //     CustomTextFormField(
                  //   label: 'Contraseña',
                  //   prefixIcon: Icon(Icons.password, color: colors.primary),
                  //   suffixIcon: PasswordSuffixIcon(
                  //     obscureText: obscureText,
                  //     onTap: ref
                  //         .read(resetPasswordFormProvider.notifier)
                  //         .onTapPasswordSuffixIcon,
                  //   ),
                  //   obscureText: obscureText,
                  //   onChanged:
                  //       ref.read(loginFormProvider.notifier).onPasswordChange,
                  //   onFieldSubmitted: (value) =>
                  //       ref.read(resetPasswordFormProvider.notifier).onFormSubmit(),
                  //   errorMessage: loginForm.isFormPosted
                  //       ? loginForm.password.errorMessage
                  //       : null,
                  // ),
                  //**** */
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Confirmar contraseña',
                    prefixIcon: Icon(Icons.password, color: colors.primary),
                    suffixIcon: PasswordSuffixIcon(
                      obscureText: obscureText,
                      onTap: ref
                          .read(resetPasswordFormProvider.notifier)
                          .onTapPasswordSuffixIcon,
                    ),
                    onChanged: ref
                        .read(resetPasswordFormProvider.notifier)
                        .onConfirmPasswordChange,
                    errorMessage: form.isFormPosted
                        ? form.confirmPassword.errorMessage
                        : null,
                    obscureText: obscureText,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomFilledButton(
                      text: 'Cambiar contraseña',
                      onPressed: form.isPosting
                          ? null
                          : ref
                              .read(resetPasswordFormProvider.notifier)
                              .onSubmit,
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
        ),
      ),
    );
  }
}
