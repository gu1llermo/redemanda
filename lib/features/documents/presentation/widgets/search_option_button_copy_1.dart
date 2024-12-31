import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class SearchOptionButton extends StatelessWidget {
  const SearchOptionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: const Icon(
          Icons.search,
          // size: 30,
        ),
      ),
      tooltip: 'Buscar',
      onSelected: (String choice) async {
        switch (choice) {
          case 'searchByDate':
            // Lógica de búsqueda por rango de fecha
            final values = await showCalendarDatePicker2Dialog(
              context: context,
              barrierLabel: 'Titulo',
              config: CalendarDatePicker2WithActionButtonsConfig(
                calendarType: CalendarDatePicker2Type.range,
                allowSameValueSelection: true,
                buttonPadding: const EdgeInsets.symmetric(horizontal: 20),

                // okButton: Icon(Icons.check_circle_outline, color: Colors.green),
                // cancelButton: Icon(Icons.cancel_outlined, color: Colors.red),
              ),
              dialogSize: const Size(355, 370),
              borderRadius: BorderRadius.circular(15),
              value: [DateTime.now()],
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
