// advanced_autocomplete_text_field_overlay.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/providers.dart';

class AdvancedAutocompleteTextFieldOverlay extends ConsumerStatefulWidget {
  final String preferencesKey;
  final String labelText;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;
  final TextCapitalization textCapitalization;
  final double width;
  final String initialValue;

  const AdvancedAutocompleteTextFieldOverlay({
    super.key,
    required this.preferencesKey,
    this.labelText = 'Introduce un valor',
    this.onChanged,
    this.textInputAction,
    this.errorMessage,
    this.helperText,
    this.textCapitalization = TextCapitalization.none,
    this.width = double.infinity,
    this.initialValue = '',
  });

  @override
  ConsumerState<AdvancedAutocompleteTextFieldOverlay> createState() =>
      _AdvancedAutocompleteTextFieldState();
}

class _AdvancedAutocompleteTextFieldState
    extends ConsumerState<AdvancedAutocompleteTextFieldOverlay> {
  late final TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialValue);
    _focusNode.addListener(_handleFocusChange);

    // Inicializar el estado con el valor inicial
    if (widget.initialValue.isNotEmpty) {
      Future.microtask(
        () {
          ref
              .read(
                  autocompleteProvider(widget.preferencesKey).notifier)
              .updateText(widget.initialValue,
                  shouldGenerateSuggestions: false);
        },
      );
    }
  }

  void _handleFocusChange() {
    Future.delayed(const Duration(milliseconds: 500), () {
      if (!_focusNode.hasFocus) {
        if (!mounted) return;
        _removeOverlay();
        final text = _textController.text.trim();
        if (text.isNotEmpty) {
          ref
              .read(
                  autocompleteProvider(widget.preferencesKey).notifier)
              .saveTermToHistory(text);
        }
        widget.onChanged?.call(text);
      }
    });

    // if (!_focusNode.hasFocus) {
    //   _removeOverlay();
    //   final text = _textController.text.trim();
    //   if (text.isNotEmpty) {
    //     ref
    //         .read(autocompleteProvider(widget.preferencesKey).notifier)
    //         .saveTermToHistory(text);
    //   }
    // }
  }

  void _showOverlay() {
    _removeOverlay();

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: _getTextFieldWidth(),
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, _getTextFieldHeight()),
          child: Material(
            elevation: 4,
            child: Consumer(
              builder: (context, ref, child) {
                final state = ref
                    .watch(autocompleteProvider(widget.preferencesKey));
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.suggestions.length,
                  itemBuilder: (context, index) {
                    final suggestion = state.suggestions[index];
                    return ListTile(
                      title: Text(suggestion),
                      trailing: IconButton(
                        icon: Icon(Icons.delete_forever_rounded),
                        onPressed: () {
                          _focusNode.requestFocus();
                          ref
                              .read(autocompleteProvider(
                                      widget.preferencesKey)
                                  .notifier)
                              .removeTermFromHistory(suggestion);
                        },
                      ),
                      onTap: () {
                        _textController.text = suggestion;
                        ref
                            .read(autocompleteProvider(
                                    widget.preferencesKey)
                                .notifier)
                            .saveTermToHistory(suggestion);
                        widget.onChanged?.call(suggestion);
                        _removeOverlay();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  double _getTextFieldWidth() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size.width ?? 300;
  }

  double _getTextFieldHeight() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 50;
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref
          .read(autocompleteProvider(widget.preferencesKey).notifier)
          .updateText(value);
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      autocompleteProvider(widget.preferencesKey)
          .select((state) => state.suggestions),
      (previous, next) {
        if (next.isNotEmpty) {
          _showOverlay();
        } else {
          _removeOverlay();
        }
      },
    );
    // ref.listen(
    //   autocompleteProvider(widget.preferencesKey)
    //       .select((state) => state.showOverlay),
    //   (previous, next) {
    //     if (next) {
    //       _showOverlay();
    //     } else {
    //       _removeOverlay();
    //     }
    //   },
    // );

    return SizedBox(
      width: widget.width,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          key: widget.key,
          focusNode: _focusNode,
          controller: _textController,
          textCapitalization: widget.textCapitalization,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            labelText: widget.labelText,
            errorText: widget.errorMessage,
            helperText: widget.helperText,
          ),
          onChanged: _onSearchChanged,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _textController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }
}
