import 'package:flutter/material.dart';
import 'dart:async';

class CustomDocumentoAdicionalTextField extends StatefulWidget {
  final String? hintText;
  final int index;
  final void Function(String, int)? onChanged;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final TextInputType? keyboardType;
  final String initialValue;

  const CustomDocumentoAdicionalTextField({
    super.key,
    this.hintText,
    this.onChanged,
    this.textInputAction,
    this.errorMessage,
    this.keyboardType,
    required this.index,
    this.initialValue = '',
  });

  @override
  State<CustomDocumentoAdicionalTextField> createState() =>
      _CustomDocumentoAdicionalTextFieldState();
}

class _CustomDocumentoAdicionalTextFieldState
    extends State<CustomDocumentoAdicionalTextField> {
  Timer? _debounce;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(CustomDocumentoAdicionalTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      _textController.text = widget.initialValue;
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
      widget.onChanged?.call(value, widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        textInputAction: widget.textInputAction,
        controller: _textController,
        decoration: InputDecoration(
          hintText: widget.hintText,
          errorText: widget.errorMessage,
          // suffixIcon: IconButton(
          //   icon: Icon(Icons.delete_forever_rounded),
          //   onPressed: () {
          //     widget.onDelete?.call(widget.index);
          //   },
          // ),
        ),
        onChanged: _onSearchChanged,
      ),
    );
  }
}
