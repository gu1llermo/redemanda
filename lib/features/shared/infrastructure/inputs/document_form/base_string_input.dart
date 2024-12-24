import 'package:formz/formz.dart';

// Define input validation types
enum BaseStringInputError { empty, format }

class BaseStringInput extends FormzInput<String, BaseStringInputError> {
  final List<BaseStringInputValidatorFunction> validators;
  final Map<BaseStringInputError, String> errorMessages;

  // const BaseStringInput.pure() : super.pure('');
  const BaseStringInput.pure({
    this.validators = const [emptyValidator],
    this.errorMessages = const {
      BaseStringInputError.empty: 'El campo es requerido',
      BaseStringInputError.format: 'No tiene formato de correo electrónico',
    },
  }) : super.pure('');

  // const BaseStringInput.dirty(super.value) : super.dirty();
  const BaseStringInput.dirty(
    super.value, {
    this.validators = const [emptyValidator],
    this.errorMessages = const {
      BaseStringInputError.empty: 'El campo es requerido',
      BaseStringInputError.format: 'No tiene formato de correo electrónico',
    },
  }) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;
    return errorMessages[displayError];
  }

  @override
  BaseStringInputError? validator(String value) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }
}

// Typedef para funciones validadoras de String
typedef BaseStringInputValidatorFunction = BaseStringInputError? Function(
    String value);

// Validadores comunes
BaseStringInputError? emptyValidator(String value) {
  if (value.trim().isEmpty) return BaseStringInputError.empty;
  return null;
}

BaseStringInputError? emailValidator(String value) {
  if (value.trim().isEmpty) return BaseStringInputError.empty;

  final emailRegExp = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );
  // final emailRegExp = RegExp(
  //   r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  // );// ésta opción me la generó la ia

  if (!emailRegExp.hasMatch(value)) return BaseStringInputError.format;
  return null;
}

class SimpleStringInput extends BaseStringInput {
  const SimpleStringInput.pure() : super.pure();
  const SimpleStringInput.dirty([super.value = '']) : super.dirty();
}

class EmailInput extends BaseStringInput {
  const EmailInput.pure()
      : super.pure(validators: const [emptyValidator, emailValidator]);

  const EmailInput.dirty([super.value = ''])
      : super.dirty(
          validators: const [emptyValidator, emailValidator],
        );
}
