import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/shared.dart';
import '../providers/providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: Align(
        alignment: Alignment.bottomCenter,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.black, Colors.white]),
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: SizedBox(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Icon Banner
                  Flexible(
                    child: Align(
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.person,
                        // Icons.gavel,
                        color: Colors.white,
                        size: 120,
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 234, 228, 228),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100)),
                      ),
                      child: const _LoginForm(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void onError(BuildContext context, String errorMessage) {
    NotificationService().showNotification(
      context: context,
      message: errorMessage,
      title: 'Error',
      type: FlushbarType.error,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final obscureText = loginForm.obscureText;

    ref.listen(
      // con ésto solo escucho los cambios de authProvider, pero sin redibujar
      // ó reconstruir el widget
      authProvider,
      (previous, next) {
        if (next.errorMessage.isEmpty) return;
        onError(context, next.errorMessage);
      },
    );

    final textStyles = Theme.of(context).textTheme;
    const maxWidth = 500.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 2,
              child:
                  Center(child: Text('Login', style: textStyles.titleLarge))),
          Flexible(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: maxWidth), // Límite de ancho
              child: CustomTextFormField(
                label: 'Correo',
                prefixIcon: Icon(Icons.email),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
                errorMessage: loginForm.isFormPosted
                    ? loginForm.email.errorMessage
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: maxWidth), // Límite de ancho
              child: CustomTextFormField(
                label: 'Contraseña',
                prefixIcon: Icon(Icons.password),
                suffixIcon: PasswordSuffixIcon(
                  obscureText: obscureText,
                  onTap: ref
                      .read(loginFormProvider.notifier)
                      .onTapPasswordSuffixIcon,
                ),
                obscureText: obscureText,
                onChanged:
                    ref.read(loginFormProvider.notifier).onPasswordChange,
                onFieldSubmitted: (value) =>
                    ref.read(loginFormProvider.notifier).onFormSubmit(),
                errorMessage: loginForm.isFormPosted
                    ? loginForm.password.errorMessage
                    : null,
              ),
            ),
          ),
          SizedBox(height: 20),
          Flexible(
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: maxWidth), // Límite de ancho
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Ingresar',
                  buttonColor: Colors.black,
                  onPressed: loginForm.isPosting
                      ? null
                      : ref.read(loginFormProvider.notifier).onFormSubmit,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {},
                    // onPressed: () => context.push('/recovery-password'),
                    child: const Text('¿Olvidó su contraseña?')),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
