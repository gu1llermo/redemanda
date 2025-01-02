import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';
import '../../../shared/shared.dart';
import '../providers/providers.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final colors = Theme.of(context).colorScheme;
    final themeMode = ref.watch(themeNotifierProvider);
    final isDarkMode = themeMode == ThemeMode.dark;

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
                colors: [
                  isDarkMode ? colors.secondary : colors.primary,
                  isDarkMode ? colors.surface : colors.secondary,
                ]),
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
                      child: Icon(
                        Icons.person,
                        color: isDarkMode ? colors.secondary : colors.onPrimary,
                        size: 120,
                      ),
                    ),
                  ),

                  Flexible(
                    flex: 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colors.surfaceContainer,
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

  // void onError(BuildContext context, String errorMessage) {
  //   NotificationService().showNotification(
  //     context: context,
  //     message: errorMessage,
  //     title: 'Error',
  //     type: FlushbarType.error,
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);
    final obscureText = loginForm.obscureText;
    final colors = Theme.of(context).colorScheme;
    final textStyles = Theme.of(context).textTheme;
    const maxWidth = 500.0;

    ref.listen(
      authProvider,
      (previous, next) {
        if (next.errorMessage.isEmpty) return;
        AppErrorsUtils.onError(context, next.errorMessage);
      },
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
              flex: 2,
              child: Center(
                  child: Text('Login',
                      style: textStyles.titleLarge
                          ?.copyWith(color: colors.onSurface)))),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: CustomTextFormField(
                label: 'Correo',
                prefixIcon: Icon(Icons.email, color: colors.primary),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
                errorMessage: loginForm.isFormPosted
                    ? loginForm.email.errorMessage
                    : null,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: CustomTextFormField(
                label: 'Contraseña',
                prefixIcon: Icon(Icons.password, color: colors.primary),
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
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: CustomFilledButton(
                  text: 'Ingresar',
                  textWidget: loginForm.isPosting
                      ? CircularProgressIndicator(
                          strokeWidth: 2, color: colors.onPrimary)
                      : null,
                  buttonColor: colors.primary,
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
                    onPressed: () => context.push('/recuperar-password'),
                    child: Text(
                      '¿Olvidó su contraseña?',
                      style: TextStyle(color: colors.primary),
                    )),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
