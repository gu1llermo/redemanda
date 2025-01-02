import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/shared.dart';
import 'providers.dart';

part 'password_recovery_form_provider.g.dart';

@Riverpod(dependencies: [authRepository])
class PasswordRecoveryForm extends _$PasswordRecoveryForm {
  @override
  PasswordRecoveryFormState build() {
    return PasswordRecoveryFormState();
  }

  void onEmailChange(String value) {
    final email = Email.dirty(value);
    state = state.copyWith(
      email: email,
      isValid: Formz.validate([email]),
    );
  }

  Future<void> onSubmitEmail() async {
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);

    try {
      await ref
          .read(authRepositoryProvider)
          .sendPasswordResetEmail(state.email.value);
      state = state.copyWith(
        isPosting: false,
        emailSent: true,
        errorMessage: '',
      );
    } catch (e) {
      state = state.copyWith(
        isPosting: false,
        errorMessage: e.toString(),
      );
    }
  }
}

class PasswordRecoveryFormState {
  final bool isPosting;
  final bool emailSent;
  final bool isValid;
  final Email email;
  final String errorMessage;

  PasswordRecoveryFormState({
    this.isPosting = false,
    this.emailSent = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.errorMessage = '',
  });

  PasswordRecoveryFormState copyWith({
    bool? isPosting,
    bool? emailSent,
    bool? isValid,
    Email? email,
    String? errorMessage,
  }) =>
      PasswordRecoveryFormState(
        isPosting: isPosting ?? this.isPosting,
        emailSent: emailSent ?? this.emailSent,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        errorMessage: errorMessage ?? this.errorMessage,
      );
}
