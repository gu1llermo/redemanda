import 'package:formz/formz.dart';

// Define input validation errors
enum Abogado2RutError { empty }

// Extend FormzInput and provide the input type and error type.
class Abogado2Rut extends FormzInput<String, Abogado2RutError> {
  // Call super.pure to represent an unmodified form input.
  const Abogado2Rut.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Abogado2Rut.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == Abogado2RutError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  Abogado2RutError? validator(String value) {
    if (value.trim().isEmpty) return Abogado2RutError.empty;

    return null;
  }
}
