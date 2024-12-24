import 'package:formz/formz.dart';

// Define input validation errors
enum DemandanteNacionalidadError { empty }

// Extend FormzInput and provide the input type and error type.
class DemandanteNacionalidad
    extends FormzInput<String, DemandanteNacionalidadError> {
  // Call super.pure to represent an unmodified form input.
  const DemandanteNacionalidad.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DemandanteNacionalidad.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DemandanteNacionalidadError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DemandanteNacionalidadError? validator(String value) {
    if (value.trim().isEmpty) return DemandanteNacionalidadError.empty;

    return null;
  }
}
