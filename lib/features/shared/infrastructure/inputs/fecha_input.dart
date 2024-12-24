import 'package:formz/formz.dart';

// Define input validation errors
enum FechaInputError { empty, invalid }

// Extend FormzInput and provide the input type and error type.
class FechaInput extends FormzInput<DateTime?, FechaInputError> {
  //static final DateTime _fechaReferencia = DateTime.now();
  // Call super.pure to represent an unmodified form input.
  // lo voy a manejar como un string, pero en realidad debería ser un DateTime
  // así que en el futuro se debería cambiar el tipo de dato de String a DateTime
  const FechaInput.pure() : super.pure(null);

  // Call super.dirty to represent a modified form input.
  const FechaInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case FechaInputError.empty:
        return 'La fecha es requerida';
      case FechaInputError.invalid:
        return 'La fecha no es válida';
      case null:
        return null;
    }
  }

  // Override validator to handle validating a given input value.
  @override
  FechaInputError? validator(DateTime? value) {
    if (value == null) return FechaInputError.empty;
    // Fecha de referencia (podría ser inyectada o constante)
    final fechaReferencia = DateTime.now();

    // Validación de fecha futura
    if (value.isAfter(fechaReferencia)) {
      return FechaInputError.invalid;
    }

    // Validación opcional de fecha muy antigua (ejemplo: más de 100 años)
    final fechaMinima =
        fechaReferencia.subtract(const Duration(days: 365 * 100));
    if (value.isBefore(fechaMinima)) {
      return FechaInputError.invalid;
    }
    return null;
  }
}
