import 'dart:async';

import 'package:flutter/material.dart';

class CustomLargeTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  // final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;
  final String initialValue;

  final TextInputType? keyboardType;
  final double width;
  final double height;

  const CustomLargeTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.onChanged,
    // this.onSubmitted,
    this.textInputAction,
    this.errorMessage,
    this.helperText,
    this.keyboardType,
    this.width = double.infinity,
    this.height = 200,
    this.initialValue = '',
  });

  @override
  State<CustomLargeTextField> createState() => _CustomLargeTextFieldState();
}

class _CustomLargeTextFieldState extends State<CustomLargeTextField> {
  Timer? _debounce;
  late final TextEditingController _textController;

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.onChanged?.call(value);
    });
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue);
  }

  // @override
  // void didUpdateWidget(CustomLargeTextField oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (widget.initialValue != oldWidget.initialValue) {
  //     _textController.text = widget.initialValue;
  //   }
  // }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;
    final radius = 12.0;
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: TextField(
        textInputAction: widget.textInputAction,
        controller: _textController,
        textAlignVertical: TextAlignVertical.top,
        expands: true,
        maxLines: null,
        minLines: null,
        decoration: InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: colors.onSurface.withAlpha(127),
            // color: colors.onSurface.withOpacity(0.5),
          ),
          errorText: widget.errorMessage,
          helperText: widget.helperText,
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
        onChanged: _onSearchChanged,
        // onChanged: widget.onChanged?.call,
        // onSubmitted: onSubmitted?.call,
      ),
    );
  }
}
