import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  // Atributos existentes
  final String? labelText;
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

  const CustomTextField({
    super.key,
    this.labelText,
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
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        textCapitalization: textCapitalization,
        textInputAction: textInputAction,
        // Forzar teclado numérico cuando es numérico
        keyboardType: isNumeric
            ? TextInputType.numberWithOptions(decimal: allowDecimals)
            : keyboardType,
        // Formatters para controlar la entrada
        inputFormatters: isNumeric
            ? [
                // Permitir solo números y coma si es decimal
                FilteringTextInputFormatter.allow(
                    allowDecimals ? RegExp(r'[0-9,]') : RegExp(r'[0-9]')),
                // Formateo específico según tipo
                TextInputFormatter.withFunction((oldValue, newValue) {
                  // Si está vacío, permitir
                  if (newValue.text.isEmpty) {
                    return newValue;
                  }

                  if (allowDecimals) {
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
          labelText: labelText,
          errorText: errorMessage,
          helperText: helperText,
        ),
        onChanged: onChanged?.call,
        onSubmitted: onSubmitted?.call,
      ),
    );
  }
}
