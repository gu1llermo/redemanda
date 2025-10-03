import 'package:formz/formz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../shared/shared.dart';
import 'providers.dart';

part 'password_recovery_form_provider.g.dart';

@Riverpod()
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
    _touchEveryField();
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

  void _touchEveryField() {
    final email = Email.dirty(state.email.value);
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      isValid: Formz.validate([email]),
    );
  }
}

class PasswordRecoveryFormState {
  final bool isPosting;
  final bool emailSent;
  final bool isValid;
  final Email email;
  final String errorMessage;
  final bool isFormPosted;

  PasswordRecoveryFormState({
    this.isPosting = false,
    this.emailSent = false,
    this.isValid = false,
    this.email = const Email.pure(),
    this.errorMessage = '',
    this.isFormPosted = false,
  });

  PasswordRecoveryFormState copyWith({
    bool? isPosting,
    bool? emailSent,
    bool? isValid,
    Email? email,
    String? errorMessage,
    bool? isFormPosted,
  }) =>
      PasswordRecoveryFormState(
        isPosting: isPosting ?? this.isPosting,
        emailSent: emailSent ?? this.emailSent,
        isValid: isValid ?? this.isValid,
        email: email ?? this.email,
        errorMessage: errorMessage ?? this.errorMessage,
        isFormPosted: isFormPosted ?? this.isFormPosted,
      );
}
