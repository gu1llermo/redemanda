import 'package:formz/formz.dart';

// Define input validation errors
enum Abogado1EmailError { empty, format }

// Extend FormzInput and provide the input type and error type.
class Abogado1Email extends FormzInput<String, Abogado1EmailError> {
  static final RegExp emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  // Call super.pure to represent an unmodified form input.
  const Abogado1Email.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Abogado1Email.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == Abogado1EmailError.empty) {
      return 'El campo es requerido';
    }
    if (displayError == Abogado1EmailError.format) {
      return 'No tiene formato de correo electrónico';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  Abogado1EmailError? validator(String value) {
    if (value.trim().isEmpty) return Abogado1EmailError.empty;
    if (!emailRegExp.hasMatch(value)) return Abogado1EmailError.format;

    return null;
  }
}
