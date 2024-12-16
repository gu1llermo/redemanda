import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';

class AdvancedAutocompleteTextFieldOverlay extends ConsumerStatefulWidget {
  final String preferencesKey;
  final String labelText;
  final ValueChanged<String>? onChanged;
  // final ValueChanged<String>? onSubmitted;
  final int historialCount;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;
  final TextCapitalization textCapitalization;
  final double width;

  const AdvancedAutocompleteTextFieldOverlay({
    super.key,
    required this.preferencesKey,
    this.labelText = 'Introduce un valor',
    this.onChanged,
    // this.onSubmitted,
    this.historialCount = 3,
    this.textInputAction,
    this.errorMessage,
    this.helperText,
    this.textCapitalization = TextCapitalization.none,
    this.width = double.infinity,
  });

  @override
  ConsumerState<AdvancedAutocompleteTextFieldOverlay> createState() =>
      _AdvancedAutocompleteTextFieldState();
}

class _AdvancedAutocompleteTextFieldState
    extends ConsumerState<AdvancedAutocompleteTextFieldOverlay> {
  List<String> _historicalTerms = [];
  final TextEditingController _textController = TextEditingController();
  List<String> _suggestions = [];
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    _loadHistoricalTerms();
    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    Future.delayed(
      Duration(milliseconds: 300),
      () {
        if (!_focusNode.hasFocus) {
          // Cuando el TextField pierde el foco, limpiar sugerencias
          if (mounted) {
            _saveTermToHistory(_textController.text);
          }
        }
      },
    );

    // if (!_focusNode.hasFocus) {
    //   _saveTermToHistory(_textController.text);

    // } else if (_suggestions.isNotEmpty) {
    //   _showOverlay();
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
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _suggestions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_suggestions[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete_forever_rounded),
                    onPressed: () {
                      _focusNode.requestFocus();
                      _removeTermFromHistory(_suggestions[index]);
                    },
                  ),
                  onTap: () async {
                    if (_suggestions.isEmpty) return;
                    _textController.text = _suggestions[index];
                    await _saveTermToHistory(_textController.text);
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
    return renderBox?.size.width ?? 300; // Fallback width
  }

  double _getTextFieldHeight() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    return renderBox?.size.height ?? 50; // Fallback height
  }

  // Los métodos _loadHistoricalTerms, _saveTermToHistory,
  // _removeTermFromHistory, _generateSuggestions son iguales
  // que en el código original

  Future<void> _loadHistoricalTerms() async {
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);

    final historicalTerms = await keyValueStorageService
            .getValue<List<String>>(widget.preferencesKey) ??
        [];

    setState(() {
      _historicalTerms = historicalTerms;
    });
  }

  Future<void> _saveTermToHistory(String term) async {
    if (term.isEmpty) {
      widget.onChanged?.call(term);
      return;
    }

    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);

    if (!_historicalTerms.contains(term)) {
      setState(() {
        _historicalTerms.insert(0, term);

        if (_historicalTerms.length > widget.historialCount) {
          _historicalTerms = _historicalTerms.sublist(0, widget.historialCount);
        }
      });

      await keyValueStorageService.setKeyValue<List<String>>(
          widget.preferencesKey, _historicalTerms);
    }

    // widget.onSubmitted?.call(term);
    widget.onChanged?.call(term);
    setState(() {
      _suggestions.clear();
      _removeOverlay();
    });
  }

  Future<void> _removeTermFromHistory(String term) async {
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);

    _historicalTerms.remove(term);
    _suggestions.remove(term);

    await keyValueStorageService.setKeyValue<List<String>>(
        widget.preferencesKey, _historicalTerms);

    setState(() {});
    _removeOverlay();
    _showOverlay();
  }

  void _generateSuggestions(String value) {
    if (value.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      _removeOverlay();
      return;
    }

    final suggestions = _historicalTerms
        .where((term) => StringUtils.searchFlexible(
              term,
              value,
              matchThreshold: 0.7,
              partialMatch: true,
              minWordLength: 1,
            ))
        .toList();

    setState(() {
      _suggestions = suggestions;
    });

    widget.onChanged?.call(value);

    if (suggestions.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          onChanged: _generateSuggestions,
          onSubmitted: _saveTermToHistory,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }
}
