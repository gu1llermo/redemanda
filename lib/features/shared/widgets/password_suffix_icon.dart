import 'package:flutter/material.dart';

class PasswordSuffixIcon extends StatelessWidget {
  const PasswordSuffixIcon(
      {super.key,
      this.visibilityOnIcon = Icons.visibility,
      this.visibilityOffIcon = Icons.visibility_off,
      required this.onTap,
      required this.obscureText});
  final IconData visibilityOnIcon;
  final IconData visibilityOffIcon;
  final bool obscureText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: obscureText ? Icon(visibilityOffIcon) : Icon(visibilityOnIcon));
  }
}
