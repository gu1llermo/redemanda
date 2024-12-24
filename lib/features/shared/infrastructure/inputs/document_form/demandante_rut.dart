import 'package:formz/formz.dart';

// Define input validation errors
enum DemandanteRutError { empty }

// Extend FormzInput and provide the input type and error type.
class DemandanteRut extends FormzInput<String, DemandanteRutError> {
  // Call super.pure to represent an unmodified form input.
  const DemandanteRut.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DemandanteRut.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DemandanteRutError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DemandanteRutError? validator(String value) {
    if (value.trim().isEmpty) return DemandanteRutError.empty;

    return null;
  }
}
