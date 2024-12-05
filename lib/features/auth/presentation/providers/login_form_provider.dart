import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:formz/formz.dart';
import '../../../shared/shared.dart';
import 'auth_provider.dart';

part 'login_form_provider.g.dart';

@riverpod
class LoginForm extends _$LoginForm {
  @override
  LoginFormState build() {
    final loginUser = ref.read(authProvider.notifier).loginUser;
    return LoginFormState(loginUser: loginUser);
  }

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

    // Deshabilitar el botón de posteo para evitar doble envío
    state = state.copyWith(isPosting: true);

    try {
      await state.loginUser(state.email.value, state.password.value);
    } finally {
      state = state.copyWith(isPosting: false);
    }
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
  final Future<void> Function(String, String) loginUser;

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.obscureText = true,
    required this.loginUser,
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Email? email,
    Password? password,
    bool? obscureText,
    Future<void> Function(String, String)? loginUser,
  }) =>
      LoginFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        password: password ?? this.password,
        obscureText: obscureText ?? this.obscureText,
        loginUser: loginUser ?? this.loginUser,
      );

  @override
  String toString() {
    return '''
  LoginFormState:
    isPosting: $isPosting
    isFormPosted: $isFormPosted
    isValid: $isValid
    email: ${email.value}
    password: ${password.value}
    obscureText: $obscureText
''';
  }
}
