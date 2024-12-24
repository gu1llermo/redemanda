import 'package:formz/formz.dart';

// Define input validation errors
enum FechaTerminoInputError { empty, invalid, minor, fechaInicioNoAsignada }

// Extend FormzInput and provide the input type and error type.
class FechaTerminoInput extends FormzInput<DateTime?, FechaTerminoInputError> {
  //static final DateTime _fechaReferencia = DateTime.now();
  // Call super.pure to represent an unmodified form input.
  // lo voy a manejar como un string, pero en realidad debería ser un DateTime
  // así que en el futuro se debería cambiar el tipo de dato de String a DateTime
  final DateTime? fechaInicio;
  const FechaTerminoInput.pure({this.fechaInicio}) : super.pure(null);

  // Call super.dirty to represent a modified form input.
  const FechaTerminoInput.dirty(super.value, {this.fechaInicio})
      : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case FechaTerminoInputError.empty:
        return 'La fecha es requerida';
      case FechaTerminoInputError.invalid:
        return 'La fecha no es válida';
      case FechaTerminoInputError.minor:
        return 'Debe ser mayor a fecha inicio';
      case FechaTerminoInputError.fechaInicioNoAsignada:
        return 'Fecha inicio no asignada';
      case null:
        return null;
    }
  }

  // Override validator to handle validating a given input value.
  @override
  FechaTerminoInputError? validator(DateTime? value) {
    if (value == null) return FechaTerminoInputError.empty;
    // Fecha de referencia (podría ser inyectada o constante)
    final fechaReferencia = DateTime.now();

    // Validación de fecha futura
    if (value.isAfter(fechaReferencia)) {
      return FechaTerminoInputError.invalid;
    }

    if (fechaInicio == null) {
      return FechaTerminoInputError.fechaInicioNoAsignada;
    }

    if (value.isBefore(fechaInicio!)) {
      return FechaTerminoInputError.minor;
    }

    // Validación opcional de fecha muy antigua (ejemplo: más de 100 años)
    // final fechaMinima =
    //     fechaReferencia.subtract(const Duration(days: 365 * 100));
    // if (value.isBefore(fechaMinima)) {
    //   return FechaTerminoInputError.invalid;
    // }
    return null;
  }
}
