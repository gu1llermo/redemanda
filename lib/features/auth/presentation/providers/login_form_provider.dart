import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import '../../../shared/shared.dart';
import 'auth_provider.dart';

final loginFormProvider =
    AutoDisposeNotifierProvider<LoginFormNotifier, LoginFormState>(
  () => LoginFormNotifier(),
);

class LoginFormNotifier extends AutoDisposeNotifier<LoginFormState> {
  @override
  LoginFormState build() {
    loginUser = ref.read(authProvider.notifier).loginUser;

    return LoginFormState();
  }

  late final Future<void> Function(String, String) loginUser;

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail, isValid: Formz.validate([newEmail, state.password]));
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate([newPassword, state.email]));
  }

  void onTapPasswordSuffixIcon() {
    state = state.copyWith(
      obscureText: !state.obscureText,
    );
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    // está haciendo esto con la finalidad deshabilitar el botón de posteo
    // para que el usuario no presione dos veces ó ingrese dos veces
    // al mismo tiempo, es como una medida de seguridad
    state = state.copyWith(isPosting: true);

    await loginUser(state.email.value, state.password.value);

    state = state.copyWith(isPosting: false);
  }

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    state = state.copyWith(
        isFormPosted: true,
        email: email,
        password: password,
        isValid: Formz.validate([email, password]));
  }
}

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;
  final bool obscureText;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.obscureText = true,
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    bool? obscureText,
  }) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          email: email ?? this.email,
          password: password ?? this.password,
          obscureText: obscureText ?? this.obscureText);

  @override
  String toString() {
    return '''
  LoginFormSate:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: ${email.value}
    password: ${password.value}
    obscureText: $obscureText
''';
  }
}
