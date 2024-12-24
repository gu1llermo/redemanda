import 'package:flutter/material.dart';

class SexSelectionButton extends StatefulWidget {
  final Function(String?)? onChanged;

  const SexSelectionButton({super.key, this.onChanged});

  @override
  State<SexSelectionButton> createState() => _SexSelectionButtonState();
}

class _SexSelectionButtonState extends State<SexSelectionButton> {
  Set<String> selection = <String>{};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      showSelectedIcon: false,
      emptySelectionAllowed: true,
      style: ButtonStyle(
        // Configuración de los estilos cuando está seleccionado
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return selection.first == 'Hombre'
                ? Colors.blue.shade300 // Azul para hombre
                : Colors.pink.shade300; // Rosado para mujer
          }
          return Colors.transparent;
        }),
      ),
      segments: const <ButtonSegment<String>>[
        ButtonSegment<String>(
          value: 'Hombre',
          label: Text('Hombre'),
        ),
        ButtonSegment<String>(
          value: 'Mujer',
          label: Text('Mujer'),
        ),
      ],
      selected: selection,
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          selection = newSelection;
        });

        // Llamar al callback onChanged con el valor seleccionado
        // Si no hay selección, se pasa null
        widget.onChanged?.call(selection.isNotEmpty ? selection.first : null);
      },
      multiSelectionEnabled: false,
    );
  }
}
