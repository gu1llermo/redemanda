import 'package:flutter/material.dart';

import 'input_form.dart';

class HoraInput extends InputForm<TimeOfDay?, HoraInput> {
  const HoraInput({
    required super.value,
    super.hasError,
  });

  @override
  HoraInput copyWith({
    TimeOfDay? value,
    bool? hasError,
  }) =>
      HoraInput(
        value: value ?? this.value,
        hasError: hasError ?? this.hasError,
      );

  @override
  String? get errorMessage {
    if (value == null) return 'La hora es requerida';
    return null;
  }
}
