import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class SearchOptionButton extends StatelessWidget {
  const SearchOptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.search),
      tooltip: 'Buscar',
      onSelected: (String choice) async {
        switch (choice) {
          case 'searchByDate':
            // Lógica de búsqueda por fecha
            final values = await showCalendarDatePicker2Dialog(
              context: context,
              config: CalendarDatePicker2WithActionButtonsConfig(
                calendarType: CalendarDatePicker2Type.range,
                allowSameValueSelection: true,
                // currentDate: DateTime.now(),
              ),
              dialogSize: const Size(325, 370),
              borderRadius: BorderRadius.circular(15),
              value: [DateTime.now()],
              //dialogBackgroundColor: Colors.white,
            );

            print('Buscar por fecha');
            break;
          case 'searchByName':
            // Lógica de búsqueda por nombre
            print('Buscar por nombre');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'searchByDate',
          child: ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Buscar por fecha'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'searchByName',
          child: ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Buscar por nombre'),
          ),
        ),
      ],
    );
  }
}

class _CalendarPicker extends StatelessWidget {
  const _CalendarPicker();

  @override
  Widget build(BuildContext context) {
    return CalendarDatePicker2(
      config: CalendarDatePicker2Config(
        calendarType: CalendarDatePicker2Type.range,
      ),
      value: [],
      onValueChanged: (value) {
        debugPrint(value.toString());
      },
    );
  }
}
