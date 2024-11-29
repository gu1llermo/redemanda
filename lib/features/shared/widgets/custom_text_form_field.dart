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

  const CustomTextFormField(
      {super.key,
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
      this.obscuringCharacter = '•'});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.circular(40));

    const borderRadius = Radius.circular(15);

    return DecoratedBox(
      // padding: const EdgeInsets.only(bottom: 0, top: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: borderRadius,
              bottomLeft: borderRadius,
              bottomRight: borderRadius),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.06),
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
        style: const TextStyle(fontSize: 20, color: Colors.black54),
        decoration: InputDecoration(
          floatingLabelStyle:
              const TextStyle(color: Colors.black, fontSize: 18),
          enabledBorder: border,
          focusedBorder: border,
          errorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          focusedErrorBorder: border.copyWith(
              borderSide: const BorderSide(color: Colors.transparent)),
          isDense: true,
          label: label != null ? Text(label!) : null,

          hintText: hint,
          errorText: errorMessage,
          focusColor: colors.primary,
          //icon: Icon(Icons.email),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
        ),
      ),
    );
  }
}
