import 'input_form.dart';

class FechaTerminoInput extends InputForm<DateTime?, FechaTerminoInput> {
  const FechaTerminoInput(
      {required super.value, super.hasError, required this.fechaInicio});
  final DateTime? fechaInicio;

  @override
  FechaTerminoInput copyWith({
    DateTime? value,
    DateTime? fechaInicio,
    bool? hasError,
  }) {
    return FechaTerminoInput(
      value: value ?? this.value,
      hasError: hasError ?? this.hasError,
      fechaInicio: fechaInicio ?? this.fechaInicio,
    );
  }

  @override
  String? get errorMessage {
    if (value == null) return 'La fecha es requerida';
    final fechaReferencia = DateTime.now();
    // Validación de fecha futura
    if (value!.isAfter(fechaReferencia)) {
      return 'La fecha no es válida';
    }
    if (fechaInicio == null) {
      return 'Fecha inicio no asignada';
    }
    if (value!.isBefore(fechaInicio!)) {
      return 'Debe ser mayor a fecha inicio';
    }
    return null;
  }
}
