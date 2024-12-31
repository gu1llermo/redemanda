import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../config/config.dart';

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
  final bool isNumeric;
  final bool allowDecimals;
  final String initialValue;
  final bool isPercentage;
  final bool isCurrency;

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
    this.initialValue = '',
    this.isPercentage = false,
    this.isCurrency = false,
  });

  @override
  State<CustomNumericTextField> createState() => _CustomNumericTextFieldState();
}

class _CustomNumericTextFieldState extends State<CustomNumericTextField> {
  Timer? _debounce;
  late TextEditingController _textController;
  String _rawValue = '';

  @override
  void initState() {
    super.initState();
    _rawValue = widget.initialValue;
    _textController = TextEditingController(text: widget.initialValue);
    if (widget.initialValue.isNotEmpty) {
      _updateText(widget.initialValue);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged?.call(_rawValue);
    });
  }

  String _cleanNumber(String text) {
    // Remover todo excepto números y la primera coma
    String cleaned = text.replaceAll(RegExp(r'[^0-9,]'), '');
    if (cleaned.contains(',')) {
      List<String> parts = cleaned.split(',');
      String integerPart = parts[0];
      String decimalPart = parts.length > 1 ? parts[1] : '';
      // Limitar a 2 decimales
      if (decimalPart.length > 2) {
        decimalPart = decimalPart.substring(0, 2);
      }
      cleaned = '$integerPart,$decimalPart';
    }
    return cleaned;
  }

  void _updateText(String newValue, {bool isBackspace = false}) {
    String cleanValue = _cleanNumber(newValue);

    if (cleanValue.isEmpty) {
      _rawValue = '';
      _textController.value = const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
      return;
    }

    try {
      String formattedText;
      int newCursorPosition;

      if (widget.isCurrency) {
        int oldOffset = _textController.selection.baseOffset;
        String oldText = _textController.text;
        String formatted = StringUtils.formatToNumber(cleanValue);
        formattedText = '\$$formatted';

        if (isBackspace) {
          newCursorPosition = oldOffset - 1;
        } else {
          newCursorPosition =
              oldOffset + (formattedText.length - oldText.length);
        }
      } else if (widget.isPercentage) {
        formattedText = '$cleanValue%';
        newCursorPosition = cleanValue.length;

        if (cleanValue.contains(',')) {
          List<String> parts = cleanValue.split(',');
          String decimalPart = parts.length > 1 ? parts[1] : '';
          if (decimalPart.length > 2) {
            cleanValue = '${parts[0]},${decimalPart.substring(0, 2)}';
            formattedText = '$cleanValue%';
          }
        }
      } else {
        formattedText = cleanValue;
        newCursorPosition = _textController.selection.baseOffset;
      }

      _rawValue = cleanValue;
      _textController.value = TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(
            offset: widget.isPercentage
                ? formattedText.length - 1
                : newCursorPosition.clamp(0, formattedText.length)),
      );
    } catch (e) {
      _rawValue = cleanValue;
      _textController.text = cleanValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: TextField(
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        controller: _textController,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
        keyboardType:
            TextInputType.numberWithOptions(decimal: widget.allowDecimals),
        inputFormatters: [
          if (widget.isNumeric) ...[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9,]')),
            TextInputFormatter.withFunction((oldValue, newValue) {
              String text = newValue.text;
              if (text.isEmpty) return newValue;

              // Permitir solo una coma
              if (text.contains(',')) {
                List<String> parts = text.split(',');
                if (parts.length > 2) {
                  return oldValue;
                }
                // Limitar decimales a 2 dígitos
                if (parts.length == 2 && parts[1].length > 2) {
                  return oldValue;
                }
              }
              return newValue;
            }),
          ],
        ],
        onChanged: (value) {
          final isBackspace = value.length < _textController.text.length;
          _updateText(value, isBackspace: isBackspace);
          _onSearchChanged(value);
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          errorText: widget.errorMessage,
          helperText: widget.helperText,
          hintText: widget.hintText,
        ),
        onSubmitted: (value) {
          widget.onSubmitted?.call(_rawValue);
        },
      ),
    );
  }
}
