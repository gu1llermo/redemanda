import 'package:formz/formz.dart';

// Define input validation errors
enum TribunalError { empty }

// Extend FormzInput and provide the input type and error type.
class Tribunal extends FormzInput<String, TribunalError> {
  // Call super.pure to represent an unmodified form input.
  const Tribunal.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Tribunal.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == TribunalError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  TribunalError? validator(String value) {
    if (value.trim().isEmpty) return TribunalError.empty;

    return null;
  }
}
