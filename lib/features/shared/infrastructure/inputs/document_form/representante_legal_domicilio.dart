import 'package:formz/formz.dart';

// Define input validation errors
enum RepresentanteLegalDomicilioError { empty }

// Extend FormzInput and provide the input type and error type.
class RepresentanteLegalDomicilio
    extends FormzInput<String, RepresentanteLegalDomicilioError> {
  // Call super.pure to represent an unmodified form input.
  const RepresentanteLegalDomicilio.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RepresentanteLegalDomicilio.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == RepresentanteLegalDomicilioError.empty) {
      return 'El campo es requerido';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  RepresentanteLegalDomicilioError? validator(String value) {
    if (value.trim().isEmpty) return RepresentanteLegalDomicilioError.empty;

    return null;
  }
}
