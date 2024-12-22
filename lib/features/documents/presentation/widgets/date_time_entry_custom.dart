import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class DateTimeEntryCustom extends StatelessWidget {
  const DateTimeEntryCustom(
      {super.key,
      this.fecha,
      required this.onFechaChanged,
      this.errorMessage,
      required this.title});
  final DateTime? fecha;
  final void Function(DateTime) onFechaChanged;
  final String? errorMessage;
  final String title;

  @override
  Widget build(BuildContext context) {
    final fechaTxt =
        fecha != null ? AppDateUtils.getFormattedDate(fecha!) : '  /  /  ';
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(title),
        TextButton(
          onPressed: () async {
            final values = await showCalendarDatePicker2Dialog(
              context: context,
              config: CalendarDatePicker2WithActionButtonsConfig(
                calendarType: CalendarDatePicker2Type.single,
                allowSameValueSelection: true,
                buttonPadding: const EdgeInsets.symmetric(horizontal: 20),
                selectableDayPredicate: (day) {
                  // Retorna true solo para días que no sean posteriores a hoy
                  return !day.isAfter(DateTime.now());
                },
              ),
              dialogSize: const Size(355, 370),
              borderRadius: BorderRadius.circular(15),
              value: [DateTime.now()],
            );
            final value = values?.first;
            if (value != null) {
              onFechaChanged(value);
            }
          },
          child: Text(fechaTxt),
        ),
        if (errorMessage != null) // es el error el que vá aparecer
          Text(
            errorMessage!,
            style: TextStyle(color: colors.error),
          ),
      ],
    );
  }
}