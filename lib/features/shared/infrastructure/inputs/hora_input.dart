import 'package:flutter/material.dart';
import 'package:formz/formz.dart';

// Define input validation errors
enum HoraInputError { empty }

// Extend FormzInput and provide the input type and error type.
class HoraInput extends FormzInput<TimeOfDay?, HoraInputError> {
  //static final DateTime _fechaReferencia = DateTime.now();
  // Call super.pure to represent an unmodified form input.
  // lo voy a manejar como un string, pero en realidad debería ser un DateTime
  // así que en el futuro se debería cambiar el tipo de dato de String a DateTime
  const HoraInput.pure() : super.pure(null);

  // Call super.dirty to represent a modified form input.
  const HoraInput.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    switch (displayError) {
      case HoraInputError.empty:
        return 'La hora es requerida';

      case null:
        return null;
    }
  }

  // Override validator to handle validating a given input value.
  @override
  HoraInputError? validator(TimeOfDay? value) {
    if (value == null) return HoraInputError.empty;

    return null;
  }
}
