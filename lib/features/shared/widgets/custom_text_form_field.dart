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

    final border = OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    return DecoratedBox(
      decoration: BoxDecoration(
          color: colors.surface, // Usa el color de superficie del tema
          borderRadius: const BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
              bottomRight: borderRadius),
          boxShadow: [
            BoxShadow(
                color: colors.shadow
                    .withOpacity(0.1), // Usa el color de sombra del tema
                blurRadius: 10,
                offset: const Offset(0, 5))
          ]),
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        obscuringCharacter: obscuringCharacter,
        onFieldSubmitted: onFieldSubmitted,
        style: TextStyle(
            fontSize: 20,
            color:
                colors.onSurface // Usa el color del texto sobre la superficie
            ),
        decoration: InputDecoration(
          floatingLabelStyle: TextStyle(
              color: colors
                  .primary, // Usa el color primario para la etiqueta flotante
              fontSize: 18),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: BorderSide(
                  color: colors.error) // Usa el color de error del tema
              ),
          focusedErrorBorder:
              border.copyWith(borderSide: BorderSide(color: colors.error)),
          isDense: true,
          label: label != null ? Text(label!) : null,
          hintText: hint,
          hintStyle: TextStyle(
              color: colors.onSurface
                  .withOpacity(0.5)), // Estilo para el texto de pista
          errorText: errorMessage,
          errorStyle:
              TextStyle(color: colors.error), // Estilo para el texto de error
          focusColor: colors.primary,
          prefixIcon: prefixIcon != null
              ? IconTheme(
                  data: IconThemeData(color: colors.primary),
                  child: prefixIcon!)
              : null,
          suffixIcon: suffixIcon,
        ),
      ),
    );
  }
}
