import 'package:flutter/material.dart';

class CustomLargeTextField extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;

  final TextInputType? keyboardType;
  final double width;
  final double height;

  const CustomLargeTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction,
    this.errorMessage,
    this.helperText,
    this.keyboardType,
    this.width = double.infinity,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
    final radius = 12.0;
    return SizedBox(
      width: width,
      height: height,
      child: TextField(
        textInputAction: textInputAction,
        // textAlign: TextAlign.start,
        textAlignVertical: TextAlignVertical.top,
        expands: true,
        maxLines: null,
        minLines: null,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          errorText: errorMessage,
          helperText: helperText,
          // Configuración del borde
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: colors.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: colors.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: colors.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: colors.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: colors.error, width: 2),
          ),
          errorMaxLines: 1,

          filled: true,
          fillColor: colors.surface,
        ),
        onChanged: onChanged?.call,
        onSubmitted: onSubmitted?.call,
      ),
    );
  }
}
