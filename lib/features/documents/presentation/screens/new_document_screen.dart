import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:redemanda/features/shared/shared.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class NewDocumentScreen extends StatelessWidget {
  const NewDocumentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Nuevo Documento')),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
          child: ListView(
            children: const [
              _InformacionDemandante(),
              SizedBox(height: 10),
              _InformacionAbogado1(),
              SizedBox(height: 10),
              _InformacionAbogado2(),
              SizedBox(height: 10),
              _InformacionDemandado(),
              SizedBox(height: 10),
              _InformacionRepresentanteLegal(),
              SizedBox(height: 30),
              _SubmitButton()
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context, ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    return ElevatedButton(
      onPressed: newDocumentState.isPosting
          ? null
          : ref.read(documentFormProvider.notifier).onFormSubmit,
      child: newDocumentState.isPosting
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : Text('Submit'),
    );
  }
}

class _InformacionDemandante extends ConsumerWidget {
  const _InformacionDemandante();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    return CardModelInformation(
      title: 'Demandante',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_demandante',
          onChanged: ref
              .read(documentFormProvider.notifier)
              .onDemandanteFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_demandante',
          onChanged:
              ref.read(documentFormProvider.notifier).onDemandanteRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteRut.errorMessage
              : null,
        ),
        GenderSelector(
          selectedGender: newDocumentState.demandanteGender,
          onGenderChanged:
              ref.read(documentFormProvider.notifier).onDemandanteGenderChanged,
        ),
        EstadoCivilDropdown(
          estadoCivilInicial: newDocumentState.demandanteEstadoCivil,
          gender: newDocumentState.demandanteGender,
          onChanged: ref
              .read(documentFormProvider.notifier)
              .onDemandanteEstadoCivilChanged,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 180,
          labelText: 'Nacionalidad',
          preferencesKey: 'nacionalidad',
          onChanged: ref
              .read(documentFormProvider.notifier)
              .onDemandanteNacionalidadChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteNacionalidad.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionAbogado1 extends ConsumerWidget {
  const _InformacionAbogado1();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    return CardModelInformation(
      title: 'Abogado 1',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_abogado',
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado1FullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado1FullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_abogado',
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado1RutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado1Rut.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 250,
          labelText: 'Correo',
          preferencesKey: 'correo_abogado',
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado1EmailChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado1Email.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionAbogado2 extends ConsumerWidget {
  const _InformacionAbogado2();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    return CardModelInformation(
      title: 'Abogado 2',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_abogado',
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado2FullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado2FullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_abogado',
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado2RutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado2Rut.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 250,
          labelText: 'Correo',
          preferencesKey: 'correo_abogado',
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado2EmailChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado2Email.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionDemandado extends ConsumerWidget {
  const _InformacionDemandado();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    return CardModelInformation(
      title: 'Demandado',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_demandado',
          onChanged: ref
              .read(documentFormProvider.notifier)
              .onDemandadoFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_demandado',
          onChanged:
              ref.read(documentFormProvider.notifier).onDemandadoRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoRut.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionRepresentanteLegal extends ConsumerWidget {
  const _InformacionRepresentanteLegal();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    return CardModelInformation(
      title: 'Representante Legal',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_representante_legal',
          onChanged: ref
              .read(documentFormProvider.notifier)
              .onRepresentanteLegalFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_representante_legal',
          onChanged: ref
              .read(documentFormProvider.notifier)
              .onRepresentanteLegalRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalRut.errorMessage
              : null,
        ),
        GenderSelector(
          selectedGender: newDocumentState.representanteLegalGender,
          onGenderChanged: ref
              .read(documentFormProvider.notifier)
              .onRepresentanteLegalGenderChanged,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Domicilio Empresa',
          preferencesKey: 'domicilio_empresa',
          onChanged: ref
              .read(documentFormProvider.notifier)
              .onRepresentanteLegalDomicilioChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalDomicilio.errorMessage
              : null,
        ),
      ],
    );
  }
}
