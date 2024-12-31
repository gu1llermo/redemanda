import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../domain/domain.dart';
import 'dart:async';

import '../widgets/widgets.dart';

enum SearchType {
  name,
  date,
}

class DocumentSearchDelegate extends SearchDelegate<Document?> {
  final WidgetRef ref;
  final SearchType searchType;
  final Future<List<Document>> Function(String term) onSearchByName;
  final Future<List<Document>> Function({
    required DateTime startDate,
    required DateTime endDate,
  }) onSearchByDateRange;

  // Agregar Timer para el debounce
  Timer? _debounceTimer;
  final _debounceMilliseconds = 500;

  DocumentSearchDelegate({
    required this.ref,
    required this.searchType,
    required this.onSearchByName,
    required this.onSearchByDateRange,
  }) : super(
          searchFieldLabel: searchType == SearchType.name
              ? 'Buscar por nombre/rut'
              : 'Seleccione un rango de fechas',
          searchFieldStyle: const TextStyle(
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
        );

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  // Función para manejar el debounce
  Future<List<Document>> _debouncedSearch(String term) async {
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    final completer = Completer<List<Document>>();

    _debounceTimer =
        Timer(Duration(milliseconds: _debounceMilliseconds), () async {
      try {
        final results = await onSearchByName(term);
        completer.complete(results);
      } catch (e) {
        completer.completeError(e);
      }
    });

    return completer.future;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          _debounceTimer?.cancel(); // Cancelar el timer al limpiar
          if (searchType == SearchType.name) {
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        _debounceTimer?.cancel(); // Cancelar el timer al salir
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (searchType == SearchType.date) {
      return _buildDateRangeSearch(context);
    }

    if (query.isEmpty) {
      return const Center(
        child: Text('Ingrese un término de búsqueda'),
      );
    }

    return FutureBuilder<List<Document>>(
      future: _debouncedSearch(query), // Usar la función con debounce
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        final documents = snapshot.data ?? [];

        if (documents.isEmpty) {
          return const Center(
            child: Text('No se encontraron documentos'),
          );
        }

        return MasonryGridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
          ),
          itemBuilder: (context, index) {
            final document = documents[index];
            return DocumentCard(
              document: document,
            );
          },
          itemCount: documents.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (searchType == SearchType.date) {
      return _buildDateRangeSearch(context);
    }

    if (query.isEmpty) {
      return const Center(
        child: Text('Ingrese un término de búsqueda'),
      );
    }

    return FutureBuilder<List<Document>>(
      future: _debouncedSearch(query), // Usar la función con debounce
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final documents = snapshot.data ?? [];

        return MasonryGridView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 400,
          ),
          itemBuilder: (context, index) {
            final document = documents[index];
            return DocumentCard(
              document: document,
            );
          },
          itemCount: documents.length,
        );
      },
    );
  }

  Widget _buildDateRangeSearch(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final values = await showCalendarDatePicker2Dialog(
                context: context,
                config: CalendarDatePicker2WithActionButtonsConfig(
                  calendarType: CalendarDatePicker2Type.range,
                  allowSameValueSelection: true,
                  buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
                ),
                dialogSize: const Size(355, 370),
                borderRadius: BorderRadius.circular(15),
                value: [DateTime.now()],
              );

              if (values != null && values.length == 2) {
                final startDate = values[0]!;
                final endDate = values[1]!;

                final documents = await onSearchByDateRange(
                  startDate: startDate,
                  endDate: endDate,
                );

                if (!context.mounted) return;

                if (documents.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'No se encontraron documentos en ese rango de fechas'),
                    ),
                  );
                  return;
                }

                close(context, documents.first);
              }
            },
            child: const Text('Seleccionar rango de fechas'),
          ),
        ],
      ),
    );
  }
}
