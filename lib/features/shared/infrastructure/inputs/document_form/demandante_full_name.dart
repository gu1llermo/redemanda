import 'package:formz/formz.dart';

// Define input validation errors
enum DemandanteFullNameError { empty }

// Extend FormzInput and provide the input type and error type.
class DemandanteFullName extends FormzInput<String, DemandanteFullNameError> {
  // Call super.pure to represent an unmodified form input.
  const DemandanteFullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DemandanteFullName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DemandanteFullNameError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DemandanteFullNameError? validator(String value) {
    if (value.trim().isEmpty) return DemandanteFullNameError.empty;

    return null;
  }
}
