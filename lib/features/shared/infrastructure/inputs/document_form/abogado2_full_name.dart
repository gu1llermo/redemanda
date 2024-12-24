import 'package:formz/formz.dart';

// Define input validation errors
enum Abogado2FullNameError { empty }

// Extend FormzInput and provide the input type and error type.
class Abogado2FullName extends FormzInput<String, Abogado2FullNameError> {
  // Call super.pure to represent an unmodified form input.
  const Abogado2FullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Abogado2FullName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == Abogado2FullNameError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  Abogado2FullNameError? validator(String value) {
    if (value.trim().isEmpty) return Abogado2FullNameError.empty;

    return null;
  }
}
