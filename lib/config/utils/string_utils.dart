import 'package:diacritic/diacritic.dart';
import 'package:intl/intl.dart';

class StringUtils {
  static bool titleContains(String titleEntry, String searchTermEntry) {
    // Elimina acentos y convierte a minúsculas
    final normalizedTitle = removeDiacritics(titleEntry.toLowerCase());
    final normalizedSearchTerm =
        removeDiacritics(searchTermEntry.toLowerCase());

    final listTitles = normalizedTitle.split(' ');
    final listSearchTerms = normalizedSearchTerm.split(' ');

    int count = 0;
    for (var i = 0; i < listSearchTerms.length; i++) {
      final searchTerm = listSearchTerms[i];
      for (var j = 0; j < listTitles.length; j++) {
        final title = listTitles[j];
        if (title.contains(searchTerm)) {
          count++;
          break;
        }
      }
    }

    return count >= listSearchTerms.length;
  }

// curiosamente es más rápido la búsqueda flexible que la búsqueda exacta
  static bool searchFlexible(
    String text,
    String searchTerm, {
    double matchThreshold = 0.7, // Umbral de coincidencia
    bool partialMatch = true, // Permitir coincidencia parcial
    int minWordLength = 1, // Longitud mínima de palabra para coincidir
  }) {
    // Normalizar texto y término de búsqueda
    final normalizedText = removeDiacritics(text.toLowerCase());
    final normalizedSearchTerm = removeDiacritics(searchTerm.toLowerCase());

    // Dividir en palabras
    final textWords = normalizedText
        .split(' ')
        .where((word) => word.length >= minWordLength)
        .toList();
    final searchWords = normalizedSearchTerm
        .split(' ')
        .where((word) => word.length >= minWordLength)
        .toList();

    // Si no hay términos de búsqueda válidos, retornar falso
    if (searchWords.isEmpty) return false;

    // Contador de coincidencias
    int matchCount = 0;

    for (final searchWord in searchWords) {
      bool wordMatched = false;

      for (final textWord in textWords) {
        // Coincidencia exacta
        if (textWord == searchWord) {
          matchCount++;
          wordMatched = true;
          break;
        }

        // Coincidencia parcial si está habilitada
        if (partialMatch && textWord.contains(searchWord)) {
          matchCount++;
          wordMatched = true;
          break;
        }
      }

      // Si no se encontró coincidencia para alguna palabra, verificar umbral
      if (!wordMatched && searchWords.length > 1) {
        // Calcular porcentaje de coincidencia
        final percentageMatch = matchCount / searchWords.length;
        return percentageMatch >= matchThreshold;
      }
    }

    // Verificar si se cumple el umbral de coincidencia
    final percentageMatch = matchCount / searchWords.length;
    return percentageMatch >= matchThreshold;
  }

  static num parseToNum(String value) {
    final formatter =
        NumberFormat.decimalPattern('es'); // o el locale que necesites
    return formatter.parse(value);
  }

  static String formatToNumber(String value) {
    value = value.trim();
    if (value.isEmpty || value.length == 1) return value;
    double number = double.parse(value.replaceAll(',', '.'));

    // Creamos el formateador con el patrón deseado
    final formatter = NumberFormat('#,##0.00', 'es');
    // Formateamos el número
    String formatted = formatter.format(number);
    return formatted;
  }
}
