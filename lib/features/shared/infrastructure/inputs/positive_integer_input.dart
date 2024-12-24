import 'package:formz/formz.dart';

// Define input validation errors
enum PositiveIntegerInputError { empty, zero, format }

// Extend FormzInput and provide the input type and error type.
class PositiveIntegerInput
    extends FormzInput<String, PositiveIntegerInputError> {
  // Call super.pure to represent an unmodified form input.
  const PositiveIntegerInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PositiveIntegerInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PositiveIntegerInputError.zero) {
      return 'Debe ser > 0';
    }
    if (displayError == PositiveIntegerInputError.empty) {
      return 'Campo requerido';
    }
    if (displayError == PositiveIntegerInputError.format) {
      return 'Formato incorrecto';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PositiveIntegerInputError? validator(String value) {
    value = value.trim();
    if (value.isEmpty) return PositiveIntegerInputError.empty;
    int valueNumber = 0;
    try {
      valueNumber = int.parse(value);
    } catch (e) {
      return PositiveIntegerInputError.format;
    }

    if (valueNumber <= 0) return PositiveIntegerInputError.zero;

    return null;
  }
}
