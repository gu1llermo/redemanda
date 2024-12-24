import 'package:formz/formz.dart';

// Define input validation errors
enum RepresentanteLegalFullNameError { empty }

// Extend FormzInput and provide the input type and error type.
class RepresentanteLegalFullName
    extends FormzInput<String, RepresentanteLegalFullNameError> {
  // Call super.pure to represent an unmodified form input.
  const RepresentanteLegalFullName.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RepresentanteLegalFullName.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == RepresentanteLegalFullNameError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  RepresentanteLegalFullNameError? validator(String value) {
    if (value.trim().isEmpty) return RepresentanteLegalFullNameError.empty;

    return null;
  }
}
