import 'package:formz/formz.dart';
import '../../../../config/config.dart';

// Define input validation errors
enum PositiveNumInputError { empty, zero, format }

// Extend FormzInput and provide the input type and error type.
class PositiveNumInput extends FormzInput<String, PositiveNumInputError> {
  // Call super.pure to represent an unmodified form input.
  const PositiveNumInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const PositiveNumInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == PositiveNumInputError.zero) {
      return 'Debe ser > 0';
    }
    if (displayError == PositiveNumInputError.empty) {
      return 'Campo requerido';
    }
    if (displayError == PositiveNumInputError.format) {
      return 'Formato incorrecto';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  PositiveNumInputError? validator(String value) {
    value = value.trim();
    if (value.isEmpty) return PositiveNumInputError.empty;
    num valueNumber = 0.0;
    try {
      // valueNumber = double.parse(value);
      valueNumber = StringUtils.parseToNum(value);
    } catch (e) {
      return PositiveNumInputError.format;
    }

    if (valueNumber <= 0.0) return PositiveNumInputError.zero;

    return null;
  }
}
