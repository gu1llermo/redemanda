import 'package:formz/formz.dart';

// Define input validation errors
enum DemandadoRutError { empty }

// Extend FormzInput and provide the input type and error type.
class DemandadoRut extends FormzInput<String, DemandadoRutError> {
  // Call super.pure to represent an unmodified form input.
  const DemandadoRut.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DemandadoRut.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DemandadoRutError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DemandadoRutError? validator(String value) {
    if (value.trim().isEmpty) return DemandadoRutError.empty;

    return null;
  }
}
