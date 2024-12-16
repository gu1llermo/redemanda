import 'package:formz/formz.dart';

// Define input validation errors
enum DemandadoFullNameError { empty }

// Extend FormzInput and provide the input type and error type.
class DemandadoFullName extends FormzInput<String, DemandadoFullNameError> {
  // Call super.pure to represent an unmodified form input.
  const DemandadoFullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DemandadoFullName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DemandadoFullNameError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DemandadoFullNameError? validator(String value) {
    if (value.trim().isEmpty) return DemandadoFullNameError.empty;

    return null;
  }
}
