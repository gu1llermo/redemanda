import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';

class AdvancedAutocompleteTextField extends ConsumerStatefulWidget {
  // Atributos para personalización y reutilización
  final String
      preferencesKey; // Clave única para guardar en KeyValueStorageService
  final String labelText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final int historialCount;
  final TextInputAction? textInputAction;
  final String? errorMessage;
  final String? helperText;
  final TextCapitalization textCapitalization;

  // Constructor con parámetros nombrados y algunos valores por defecto
  const AdvancedAutocompleteTextField(
      {super.key,
      required this.preferencesKey, // Requerido para identificar el historial único
      this.labelText = 'Introduce un valor',
      this.onChanged,
      this.onSubmitted,
      this.historialCount = 3,
      this.textInputAction,
      this.errorMessage,
      this.helperText,
      this.textCapitalization = TextCapitalization.none});

  @override
  ConsumerState<AdvancedAutocompleteTextField> createState() =>
      _AdvancedAutocompleteTextFieldState();
}

class _AdvancedAutocompleteTextFieldState
    extends ConsumerState<AdvancedAutocompleteTextField> {
  // Lista para almacenar términos históricos
  List<String> _historicalTerms = [];

  // Controlador para manejar el texto del campo
  final TextEditingController _textController = TextEditingController();

  // Lista para mostrar sugerencias mientras se escribe
  List<String> _suggestions = [];

  // Clave para animaciones de lista
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  // FocusNode para manejar el foco del TextField
  final FocusNode _focusNode = FocusNode();

  // bool _deleitingItem = false;

  @override
  void initState() {
    super.initState();
    // Cargar términos históricos al iniciar
    _loadHistoricalTerms();

    // Agregar listener para manejar el foco
    _focusNode.addListener(_handleFocusChange);
  }

  // Manejar cambios de foco
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
  }

  // Cargar términos históricos desde el almacenamiento local
  Future<void> _loadHistoricalTerms() async {
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);

    final historicalTerms = await keyValueStorageService
            .getValue<List<String>>(widget.preferencesKey) ??
        [];

    setState(() {
      _historicalTerms = historicalTerms;
    });
  }

  // Guardar un nuevo término en el historial
  Future<void> _saveTermToHistory(String term) async {
    if (term.isEmpty) return;

    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);

    // Evitar duplicados
    if (!_historicalTerms.contains(term)) {
      setState(() {
        _historicalTerms.insert(0, term); // Agregar al inicio

        // Limitar el historial a los últimos historialCount términos
        if (_historicalTerms.length > widget.historialCount) {
          _historicalTerms = _historicalTerms.sublist(0, widget.historialCount);
        }
      });

      // Guardar en KeyValueStorageService usando la clave específica
      await keyValueStorageService.setKeyValue<List<String>>(
          widget.preferencesKey, _historicalTerms);
    }
    // Llamar al callback onSubmitted si está definido
    widget.onSubmitted?.call(term);
    setState(() {
      _suggestions.clear();
    });
  }

  // Eliminar un término del historial
  Future<void> _removeTermFromHistory(String term) async {
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);

    _historicalTerms.remove(term);
    _suggestions.remove(term);

    // Actualizar KeyValueStorageService con la clave específica
    await keyValueStorageService.setKeyValue<List<String>>(
        widget.preferencesKey, _historicalTerms);

    setState(() {});
  }

  // Generar sugerencias usando StringUtils.searchFlexible
  void _generateSuggestions(String value) {
    if (value.isEmpty) {
      setState(() {
        _suggestions = [];
      });
      return;
    }

    // Usar StringUtils.searchFlexible para generar sugerencias
    final suggestions = _historicalTerms
        .where((term) => StringUtils.searchFlexible(
              term, value,
              matchThreshold: 0.7, // Similar to the previous Fuzzy threshold
              partialMatch: true,
              minWordLength: 1,
            ))
        .toList();

    setState(() {
      _suggestions = suggestions;
    });

    // Llamar al callback onChanged si está definido
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Campo de texto con animación de sugerencias
        TextField(
          key: widget.key,
          focusNode: _focusNode, // Asignar el FocusNode
          controller: _textController,
          textCapitalization: widget.textCapitalization,

          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            //hintText: widget.hintText, // Usar el hintText proporcionado
            labelText: widget.labelText,
            errorText: widget.errorMessage,
            helperText: widget.helperText,

            // suffixIcon: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     if (_textController.text.isNotEmpty)
            //       IconButton(
            //         icon: Icon(Icons.clear_rounded),
            //         onPressed: () {
            //           _textController.clear();
            //           setState(() {
            //             _suggestions = [];
            //           });
            //         },
            //       ),
            //   ],
            // ),
          ),
          onChanged: _generateSuggestions,
          onSubmitted: _saveTermToHistory,
        ),

        // Mostrar sugerencias
        if (_suggestions.isNotEmpty)
          ListView.builder(
            key: _listKey,
            shrinkWrap: true,
            itemCount: _suggestions.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_suggestions[index]),
                trailing: IconButton(
                  icon: Icon(Icons.delete_forever_rounded),
                  onPressed: () {
                    // Eliminar término del historial
                    _focusNode.requestFocus();
                    _removeTermFromHistory(_suggestions[index]);

                    // Eliminar de la lista de sugerencias con animación
                    _listKey.currentState?.removeItem(
                      index,
                      (context, animation) => SizeTransition(
                        sizeFactor: animation,
                        child:
                            SizedBox(), // Widget vacío para la animación de salida
                      ),
                      duration: Duration(milliseconds: 300),
                    );
                  },
                ),
                onTap: () async {
                  // Al tocar una sugerencia, llenar el campo
                  if (_suggestions.isEmpty) return;
                  _textController.text = _suggestions[index];
                  await _saveTermToHistory(_textController.text);

                  // _focusNode.nextFocus();

                  // setState(() {
                  //   _suggestions.clear();
                  // });
                },
              );
            },
          ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }
}
