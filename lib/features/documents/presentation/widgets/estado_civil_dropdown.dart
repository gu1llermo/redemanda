import 'package:flutter/material.dart';

import '../providers/forms/estado_civil.dart';

class EstadoCivilDropdown extends StatelessWidget {
  final EstadoCivil estadoCivilInicial;
  final void Function(EstadoCivil)? onChanged;
  final Gender gender;
  final double? width;

  const EstadoCivilDropdown(
      {super.key,
      required this.estadoCivilInicial,
      this.onChanged,
      required this.gender,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 120.0,
      child: DropdownButton<EstadoCivil>(
        value: estadoCivilInicial,
        hint: const Text('Seleccione estado civil'),
        isExpanded: true,
        underline: Container(
          height: 1,
          color: Theme.of(context).dividerColor,
        ),
        onChanged: (EstadoCivil? nuevoEstado) {
          if (nuevoEstado == null) return;
          if (onChanged == null) return;
          onChanged!(nuevoEstado);
        },
        items: EstadoCivil.values
            .map<DropdownMenuItem<EstadoCivil>>((EstadoCivil estado) {
          return DropdownMenuItem<EstadoCivil>(
            value: estado,
            child: Text(
              estado.texto(gender),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        }).toList(),
      ),
    );
  }
}
