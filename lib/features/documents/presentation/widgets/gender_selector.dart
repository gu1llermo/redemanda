import 'package:flutter/material.dart';

import '../providers/forms/estado_civil.dart';

class GenderSelector extends StatelessWidget {
  final Gender selectedGender;
  final List<Gender> genders = Gender.values;
  final List<IconData> genderIcons = const [
    Icons.man,
    Icons.woman,
  ];
  final void Function(Gender selectedGender) onGenderChanged;

  const GenderSelector(
      {super.key, required this.selectedGender, required this.onGenderChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton(
      multiSelectionEnabled: false,
      showSelectedIcon: false,
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return selectedGender == Gender.hombre
                ? Colors.blue.shade400 // Azul para hombre
                : Colors.pink.shade400; // Rosado para mujer
          }
          return Colors.transparent;
        }),
      ),
      segments: genders.map((value) {
        return ButtonSegment(
            icon: Icon(genderIcons[genders.indexOf(value)]),
            value: value,
            label: Text(value.name, style: const TextStyle(fontSize: 12)));
      }).toList(),
      selected: {selectedGender},
      onSelectionChanged: (newSelection) {
        FocusScope.of(context).unfocus();
        onGenderChanged(newSelection.first);
        //debugPrint(newSelection.toString());
      },
    );
  }
}
