import 'package:formz/formz.dart';

// Define input validation errors
enum FechaInicioRelacionLaboralError { empty, invalid }

// Extend FormzInput and provide the input type and error type.
class FechaInicioRelacionLaboral
    extends FormzInput<DateTime?, FechaInicioRelacionLaboralError> {
  //static final DateTime _fechaReferencia = DateTime.now();
  // Call super.pure to represent an unmodified form input.
  // lo voy a manejar como un string, pero en realidad debería ser un DateTime
  // así que en el futuro se debería cambiar el tipo de dato de String a DateTime
  const FechaInicioRelacionLaboral.pure() : super.pure(null);

  // Call super.dirty to represent a modified form input.
  const FechaInicioRelacionLaboral.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case FechaInicioRelacionLaboralError.empty:
        return 'El campo es requerido';
      case FechaInicioRelacionLaboralError.invalid:
        return 'La fecha no es válida';
      case null:
        return null;
    }
  }

  // Override validator to handle validating a given input value.
  @override
  FechaInicioRelacionLaboralError? validator(DateTime? value) {
    if (value == null) return FechaInicioRelacionLaboralError.empty;
    // Fecha de referencia (podría ser inyectada o constante)
    final fechaReferencia = DateTime.now();

    // Validación de fecha futura
    if (value.isAfter(fechaReferencia)) {
      return FechaInicioRelacionLaboralError.invalid;
    }

    // Validación opcional de fecha muy antigua (ejemplo: más de 100 años)
    final fechaMinima =
        fechaReferencia.subtract(const Duration(days: 365 * 100));
    if (value.isBefore(fechaMinima)) {
      return FechaInicioRelacionLaboralError.invalid;
    }
    return null;
  }
}
