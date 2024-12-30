import 'package:formz/formz.dart';

// Define input validation errors
enum FechaAccidenteInputError { empty, invalid, fechasNoAsignadas, outRange }

// Extend FormzInput and provide the input type and error type.
class FechaAccidenteInput
    extends FormzInput<DateTime?, FechaAccidenteInputError> {
  //static final DateTime _fechaReferencia = DateTime.now();
  // Call super.pure to represent an unmodified form input.
  // lo voy a manejar como un string, pero en realidad debería ser un DateTime
  // así que en el futuro se debería cambiar el tipo de dato de String a DateTime
  final DateTime? fechaInicio;
  final DateTime? fechaTermino;
  const FechaAccidenteInput.pure({this.fechaInicio, this.fechaTermino})
      : super.pure(null);

  // Call super.dirty to represent a modified form input.
  const FechaAccidenteInput.dirty(super.value,
      {this.fechaInicio, this.fechaTermino})
      : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case FechaAccidenteInputError.empty:
        return 'La fecha es requerida';
      case FechaAccidenteInputError.invalid:
        return 'La fecha no es válida';
      case FechaAccidenteInputError.fechasNoAsignadas:
        return 'Fechas inicio/término no asignadas';
      case FechaAccidenteInputError.outRange:
        return 'Fuera de rango';
      case null:
        return null;
    }
  }

  // Override validator to handle validating a given input value.
  @override
  FechaAccidenteInputError? validator(DateTime? value) {
    if (value == null) return FechaAccidenteInputError.empty;
    // Fecha de referencia (podría ser inyectada o constante)
    final fechaReferencia = DateTime.now();

    // Validación de fecha futura
    if (value.isAfter(fechaReferencia)) {
      return FechaAccidenteInputError.invalid;
    }

    if (fechaInicio == null || fechaTermino == null) {
      return FechaAccidenteInputError.fechasNoAsignadas;
    }

    if (value.isBefore(fechaInicio!) || value.isAfter(fechaTermino!)) {
      return FechaAccidenteInputError.outRange;
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
