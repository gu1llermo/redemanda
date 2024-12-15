import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redemanda/features/shared/shared.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class NewDocumentScreen extends ConsumerWidget {
  const NewDocumentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Nuevo Documento')),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
          child: ListView(
            children: [
              _InformacionDemandante(),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformacionDemandante extends StatelessWidget {
  const _InformacionDemandante();

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Información del Demandante',
      children: [
        SizedBox(
          width: 300,
          child: AdvancedAutocompleteTextFieldOverlay(
            labelText: 'Nombre Completo',
            preferencesKey: 'nombre_demandante',
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 200,
          child: AdvancedAutocompleteTextFieldOverlay(
            labelText: 'Rut/CI',
            preferencesKey: 'rut_demandante',
          ),
        ),
        const SizedBox(width: 10),
        GenderSelector(
          selectedGender: Gender.hombre,
          onGenderChanged: (selectedGender) {},
        ),
        const SizedBox(width: 10),
        EstadoCivilDropdown(
          estadoCivilInicial: EstadoCivil.casado,
          gender: Gender.hombre,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
