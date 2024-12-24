import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumericTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final double width;
  // Atributos para control numérico
  final bool isNumeric;
  final bool allowDecimals;

  const CustomNumericTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.errorMessage,
    this.helperText,
    this.textCapitalization = TextCapitalization.none,
    this.keyboardType,
    this.width = 200,
    this.isNumeric = false,
    this.allowDecimals = false,
  });

  @override
  State<CustomNumericTextField> createState() => _CustomNumericTextFieldState();
}

class _CustomNumericTextFieldState extends State<CustomNumericTextField> {
  Timer? _debounce;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      widget.onChanged?.call(value);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        // Forzar teclado numérico cuando es numérico
        keyboardType: widget.isNumeric
            ? TextInputType.numberWithOptions(decimal: widget.allowDecimals)
            : widget.keyboardType,
        // Formatters para controlar la entrada
        inputFormatters: widget.isNumeric
            ? [
                // Permitir solo números y coma si es decimal
                FilteringTextInputFormatter.allow(widget.allowDecimals
                    ? RegExp(r'[0-9,]')
                    : RegExp(r'[0-9]')),
                // Formateo específico según tipo
                TextInputFormatter.withFunction((oldValue, newValue) {
                  // Si está vacío, permitir
                  if (newValue.text.isEmpty) {
                    return newValue;
                  }

                  if (widget.allowDecimals) {
                    // Verificar formato decimal
                    if (RegExp(r'^\d*,?\d*$').hasMatch(newValue.text)) {
                      // Evitar múltiples comas
                      if (newValue.text.indexOf(',') !=
                          newValue.text.lastIndexOf(',')) {
                        return oldValue;
                      }
                      return newValue;
                    }
                  } else {
                    // Verificar formato entero
                    if (RegExp(r'^\d+$').hasMatch(newValue.text)) {
                      return newValue;
                    }
                  }
                  return oldValue;
                }),
              ]
            : null,
        decoration: InputDecoration(
          labelText: widget.labelText,
          errorText: widget.errorMessage,
          helperText: widget.helperText,
          hintText: widget.hintText,
        ),
        onChanged: _onSearchChanged,
        // onChanged: widget.onChanged?.call,
        onSubmitted: widget.onSubmitted?.call,
      ),
    );
  }
}
