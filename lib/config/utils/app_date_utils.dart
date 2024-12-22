import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppDateUtils {
  static String getFormattedDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String getFormattedHora(TimeOfDay hora) {
    return '${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}';
    ;
  }

  static String getCustomFormattedDate(DateTime date,
      [String format = "dd 'de' MMMM 'de' yyyy"]) {
    return DateFormat(format, 'es').format(date);
  }
}
