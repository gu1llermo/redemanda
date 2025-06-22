// autocomplete_state.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../config/config.dart';

part 'autocomplete_state.g.dart';

class AutocompleteState {
  final String currentText;
  final List<String> suggestions;
  final List<String> historicalTerms;

  const AutocompleteState({
    this.currentText = '',
    this.suggestions = const [],
    this.historicalTerms = const [],
  });

  AutocompleteState copyWith({
    String? currentText,
    List<String>? suggestions,
    List<String>? historicalTerms,
  }) =>
      AutocompleteState(
        currentText: currentText ?? this.currentText,
        suggestions: suggestions ?? this.suggestions,
        historicalTerms: suggestions ?? this.suggestions,
      );

  // const factory AutocompleteState({
  //   @Default('') String currentText,
  //   @Default([]) List<String> suggestions,
  //   @Default([]) List<String> historicalTerms,
  //   // @Default(false) bool showOverlay,
  // }) = _AutocompleteState;
}

@Riverpod(dependencies: [keyValueStorageService])
class AutocompleteNotifier extends _$AutocompleteNotifier {
  @override
  AutocompleteState build(String preferencesKey) {
    Future.microtask(_loadHistoricalTerms);
    return const AutocompleteState();
  }

  Future<void> _loadHistoricalTerms() async {
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);
    final historicalTerms =
        await keyValueStorageService.getValue<List<String>>(preferencesKey) ??
            [];

    state = state.copyWith(historicalTerms: historicalTerms);
  }

  void updateText(String value, {bool shouldGenerateSuggestions = true}) {
    state = state.copyWith(currentText: value);
    if (shouldGenerateSuggestions) {
      _generateSuggestions(value);
    }
  }

  void _generateSuggestions(String value) {
    value = value.trim();
    if (value.isEmpty) {
      state = state.copyWith(suggestions: []);
      // state = state.copyWith(suggestions: [], showOverlay: false);
      return;
    }

    final suggestions = state.historicalTerms
        .where((term) => StringUtils.searchFlexible(
              term,
              value,
              matchThreshold: 0.7,
              partialMatch: true,
              minWordLength: 1,
            ))
        .toList();

    state = state.copyWith(
      suggestions: suggestions,
      // showOverlay: suggestions.isNotEmpty,
    );
  }

  Future<void> saveTermToHistory(String term) async {
    if (term.isEmpty) return;

    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);
    final currentTerms = List<String>.from(state.historicalTerms);

    if (!currentTerms.contains(term)) {
      currentTerms.insert(0, term);
      if (currentTerms.length > 3) {
        // historialCount como parámetro si lo necesitas
        currentTerms.removeLast();
      }

      await keyValueStorageService.setKeyValue<List<String>>(
          preferencesKey, currentTerms);
      state = state.copyWith(
        historicalTerms: currentTerms,
        suggestions: [],
        // showOverlay: false,
      );
    }
  }

  Future<void> removeTermFromHistory(String term) async {
    final keyValueStorageService = ref.read(keyValueStorageServiceProvider);
    final currentTerms = List<String>.from(state.historicalTerms);
    currentTerms.remove(term);

    await keyValueStorageService.setKeyValue<List<String>>(
        preferencesKey, currentTerms);

    state = state.copyWith(
      historicalTerms: currentTerms,
      suggestions: state.suggestions.where((s) => s != term).toList(),
    );
  }

  // void setOverlayVisibility(bool visible) {
  //   state = state.copyWith(showOverlay: visible);
  // }
}
