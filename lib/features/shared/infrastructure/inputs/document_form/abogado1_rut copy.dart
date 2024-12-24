import 'package:formz/formz.dart';

// Define input validation errors
enum Abogado1RutError { empty }

// Extend FormzInput and provide the input type and error type.
class Abogado1Rut extends FormzInput<String, Abogado1RutError> {
  // Call super.pure to represent an unmodified form input.
  const Abogado1Rut.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Abogado1Rut.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == Abogado1RutError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  Abogado1RutError? validator(String value) {
    if (value.trim().isEmpty) return Abogado1RutError.empty;

    return null;
  }
}
