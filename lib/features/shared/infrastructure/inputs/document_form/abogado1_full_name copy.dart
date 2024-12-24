import 'package:formz/formz.dart';

// Define input validation errors
enum Abogado1FullNameError { empty }

// Extend FormzInput and provide the input type and error type.
class Abogado1FullName extends FormzInput<String, Abogado1FullNameError> {
  // Call super.pure to represent an unmodified form input.
  const Abogado1FullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Abogado1FullName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == Abogado1FullNameError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  Abogado1FullNameError? validator(String value) {
    if (value.trim().isEmpty) return Abogado1FullNameError.empty;

    return null;
  }
}
