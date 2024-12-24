import 'package:formz/formz.dart';

// Define input validation errors
enum SimpleStringInputError { empty }

// Extend FormzInput and provide the input type and error type.
class SimpleStringInput extends FormzInput<String, SimpleStringInputError> {
  // Call super.pure to represent an unmodified form input.
  const SimpleStringInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const SimpleStringInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SimpleStringInputError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SimpleStringInputError? validator(String value) {
    if (value.trim().isEmpty) return SimpleStringInputError.empty;

    return null;
  }
}
