import 'package:formz/formz.dart';

// Define input validation errors
enum RepresentanteLegalRutError { empty }

// Extend FormzInput and provide the input type and error type.
class RepresentanteLegalRut
    extends FormzInput<String, RepresentanteLegalRutError> {
  // Call super.pure to represent an unmodified form input.
  const RepresentanteLegalRut.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RepresentanteLegalRut.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == RepresentanteLegalRutError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  RepresentanteLegalRutError? validator(String value) {
    if (value.trim().isEmpty) return RepresentanteLegalRutError.empty;

    return null;
  }
}
