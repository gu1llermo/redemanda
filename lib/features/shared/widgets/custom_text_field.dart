import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';

class CustomTextField extends ConsumerStatefulWidget {
  // Atributos para personalización y reutilización

  final String labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;
  final TextCapitalization textCapitalization;

  // Constructor con parámetros nombrados y algunos valores por defecto
  const CustomTextField(
      {super.key,
      this.labelText = 'Introduce un valor',
      this.onChanged,
      this.onSubmitted,
      this.textInputAction,
      this.errorMessage,
      this.helperText,
      this.textCapitalization = TextCapitalization.none});

  @override
  ConsumerState<CustomTextField> createState() =>
      _AdvancedAutocompleteTextFieldState();
}

class _AdvancedAutocompleteTextFieldState
    extends ConsumerState<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: widget.textCapitalization,
      textInputAction: widget.textInputAction,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorMessage,
        helperText: widget.helperText,
      ),
      onChanged: widget.onChanged?.call,
      onSubmitted: widget.onSubmitted.call,
    );
  }
}
