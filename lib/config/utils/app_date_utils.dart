import 'package:intl/intl.dart';

class AppDateUtils {
  static String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String getCustomFormattedDate(DateTime date,
      [String format = "dd MMMM 'de' yyyy"]) {
    return DateFormat(format, 'es').format(date);
  }
}
