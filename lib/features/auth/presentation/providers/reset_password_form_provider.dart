import 'package:formz/formz.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/shared.dart';
import 'providers.dart';

part 'reset_password_form_provider.g.dart';

@Riverpod(dependencies: [authRepository])
class ResetPasswordForm extends _$ResetPasswordForm {
  @override
  ResetPasswordFormState build() {
    return ResetPasswordFormState();
  }

  void onPasswordChange(String value) {
    final password = Password.dirty(value);
    final confirmPassword = RepeatPassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );

    state = state.copyWith(
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([password, confirmPassword]),
    );
  }

  void onConfirmPasswordChange(String value) {
    final confirmPassword = RepeatPassword.dirty(
      password: state.password.value,
      value: value,
    );

    state = state.copyWith(
      confirmPassword: confirmPassword,
      isValid: Formz.validate([state.password, confirmPassword]),
    );
  }

  void onTapPasswordSuffixIcon() {
    state = state.copyWith(
      obscureText: !state.obscureText,
    );
  }

  Future<void> onSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    try {
      await ref
          .read(authRepositoryProvider)
          .resetPassword(state.password.value);
      state = state.copyWith(
        isPosting: false,
        success: true,
        errorMessage: '',
      );

      // En lugar de navegar directamente, actualizamos el estado
      Future.delayed(const Duration(seconds: 2), () {
        state = state.copyWith(shouldNavigateToLogin: true, isPosting: false);
      });
    } catch (e) {
      print(e);
      state = state.copyWith(
        isPosting: false,
        errorMessage: e.toString(),
      );
    }
  }

  void _touchEveryField() {
    final password = Password.dirty(state.password.value);
    final confirmPassword = RepeatPassword.dirty(
      password: password.value,
      value: state.confirmPassword.value,
    );

    state = state.copyWith(
      isFormPosted: true,
      password: password,
      confirmPassword: confirmPassword,
      isValid: Formz.validate([password, confirmPassword]),
    );
  }
}

class ResetPasswordFormState {
  final bool isPosting;
  final bool success;
  final bool isValid;
  final Password password;
  final RepeatPassword confirmPassword;
  final String errorMessage;
  final bool shouldNavigateToLogin;
  final bool isFormPosted;
  final bool obscureText;

  ResetPasswordFormState({
    this.isPosting = false,
    this.success = false,
    this.isValid = false,
    this.password = const Password.pure(),
    this.confirmPassword = const RepeatPassword.pure(),
    this.errorMessage = '',
    this.shouldNavigateToLogin = false,
    this.isFormPosted = false,
    this.obscureText = true,
  });

  ResetPasswordFormState copyWith({
    bool? isPosting,
    bool? success,
    bool? isValid,
    Password? password,
    RepeatPassword? confirmPassword,
    String? errorMessage,
    bool? shouldNavigateToLogin,
    bool? isFormPosted,
    bool? obscureText,
  }) =>
      ResetPasswordFormState(
        isPosting: isPosting ?? this.isPosting,
        success: success ?? this.success,
        isValid: isValid ?? this.isValid,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        errorMessage: errorMessage ?? this.errorMessage,
        shouldNavigateToLogin:
            shouldNavigateToLogin ?? this.shouldNavigateToLogin,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        obscureText: obscureText ?? this.obscureText,
      );
}
