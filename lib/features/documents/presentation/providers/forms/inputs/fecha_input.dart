import 'input_form.dart';

class FechaInput extends InputForm<DateTime?, FechaInput> {
  const FechaInput({required super.value, super.hasError});

  @override
  FechaInput copyWith({
    DateTime? value,
    bool? hasError,
  }) {
    return FechaInput(
      value: value ?? this.value,
      hasError: hasError ?? this.hasError,
    );
  }

  @override
  String? get errorMessage {
    if (value == null) return 'La fecha es requerida';
    // Fecha de referencia (podría ser inyectada o constante)
    final fechaReferencia = DateTime.now();

    // Validación de fecha futura
    if (value!.isAfter(fechaReferencia)) {
      return 'La fecha no es válida';
    }

    // Validación opcional de fecha muy antigua (ejemplo: más de 100 años)
    final fechaMinima =
        fechaReferencia.subtract(const Duration(days: 365 * 100));
    if (value!.isBefore(fechaMinima)) {
      return 'La fecha no es válida';
    }
    return null;
  }
}
