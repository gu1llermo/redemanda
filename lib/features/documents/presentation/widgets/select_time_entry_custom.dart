import 'package:flutter/material.dart';

import '../../../../config/config.dart';

class SelectTimeEntryCustom extends StatelessWidget {
  const SelectTimeEntryCustom(
      {super.key,
      this.hora,
      required this.onHoraChanged,
      this.errorMessage,
      required this.title});
  final TimeOfDay? hora;
  final void Function(TimeOfDay) onHoraChanged;
  final String? errorMessage;
  final String title;

  @override
  Widget build(BuildContext context) {
    final horaTxt =
        hora != null ? AppDateUtils.getFormattedHora(hora!) : '  :  ';
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(title),
        TextButton(
          onPressed: () async {
            final TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) {
              onHoraChanged(picked);
            }
          },
          child: Text(horaTxt),
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
