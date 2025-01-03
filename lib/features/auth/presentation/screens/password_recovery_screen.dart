import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/config.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/providers.dart';

class PasswordRecoveryScreen extends ConsumerWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final form = ref.watch(passwordRecoveryFormProvider);

    ref.listen(passwordRecoveryFormProvider, (previous, next) {
      if (next.errorMessage.isNotEmpty) {
        AppErrorsUtils.onError(context, next.errorMessage);
        return;
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Recuperar Contraseña')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!form.emailSent) ...[
                  Text(
                    'Ingresa tu correo electrónico para recibir las instrucciones de recuperación',
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    label: 'Correo electrónico',
                    onChanged: ref
                        .read(passwordRecoveryFormProvider.notifier)
                        .onEmailChange,
                    errorMessage:
                        form.isFormPosted ? form.email.errorMessage : null,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomFilledButton(
                      text: 'Enviar instrucciones',
                      textWidget: SizedBox(
                          width: 20,
                          height: 20,
                          child:
                              const CircularProgressIndicator(strokeWidth: 4)),
                      onPressed: form.isPosting
                          ? null
                          : ref
                              .read(passwordRecoveryFormProvider.notifier)
                              .onSubmitEmail,
                      buttonColor: colors.primary,
                    ),
                  ),
                ] else ...[
                  const Icon(Icons.mark_email_read, size: 100),
                  const SizedBox(height: 20),
                  Text(
                    'Se han enviado las instrucciones a tu correo',
                    style: Theme.of(context).textTheme.titleMedium,
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
