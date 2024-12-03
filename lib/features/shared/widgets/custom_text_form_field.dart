import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String obscuringCharacter;
  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.textInputAction,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.obscuringCharacter = '•',
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final radius = 12.0;

    return TextFormField(
      key: key,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      obscuringCharacter: obscuringCharacter,
      // style: textTheme.bodyMedium?.copyWith(color: colors.onSurface),
      cursorColor: colors.primary,
      decoration: InputDecoration(
        isDense: false,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        hintStyle: textTheme.bodyMedium
            ?.copyWith(color: colors.onSurface.withOpacity(0.6)),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorMessage,
        errorStyle: textTheme.bodySmall?.copyWith(
          color: colors.error,
          height: 0.7,
        ),

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

        // Relleno y márgenes
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12 // Aumentar ligeramente el padding vertical
            ),
        errorMaxLines: 1,

        filled: true,
        fillColor: colors.surface,
      ),
    );
  }
}
