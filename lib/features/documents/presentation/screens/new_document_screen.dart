import 'package:flutter/material.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:redemanda/features/shared/shared.dart';

import '../../../../config/config.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class NewDocumentScreen extends ConsumerWidget {
  const NewDocumentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    final information = ListView(
      children: const [
        _InformacionDemandante(),
        SizedBox(height: 5),
        _InformacionAbogado1(),
        SizedBox(height: 5),
        _InformacionAbogado2(),
        SizedBox(height: 5),
        _InformacionDemandado(),
        SizedBox(height: 5),
        _InformacionRepresentanteLegal(),
        SizedBox(height: 40),
        // _SubmitButton()
      ],
    );
    final details = ListView(children: [
      _DetallesAdicionales(),
      SizedBox(height: 5),
    ]);
    final widgetOptions = [
      information,
      details,
    ];
    // Listener para cambiar el índice seleccionado cuando cambia la página
    // ref.listen(documentFormProvider.select((state) => state.selectedIndex),
    //     (previous, next) {
    //   if (previous != next) {
    //     newDocumentState.pageController.animateToPage(
    //       next,
    //       duration: const Duration(milliseconds: 500),
    //       curve: Curves.easeOut,
    //     );
    //   }
    // });

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Nuevo Documento')),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
          // child: PageView(
          //   controller: newDocumentState.pageController,
          //   physics:
          //       const NeverScrollableScrollPhysics(), // Prevenir desplazamiento manual
          //   children: widgetOptions,
          //   onPageChanged: (index) {
          //     // Actualizar el índice seleccionado en el estado
          //     ref
          //         .read(documentFormProvider.notifier)
          //         .onSelectedIndexChanged(index);
          //   },
          // ),
          child: IndexedStack(
            index: newDocumentState.selectedIndex,
            children: widgetOptions,
          ),
        ),
        floatingActionButton: _GenerateButton(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline_rounded),
              label: 'Información',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.details_rounded),
              label: 'Detalles',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.school),
            //   label: 'School',
            // ),
          ],
          currentIndex: newDocumentState.selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: ref.read(documentFormProvider.notifier).onSelectedIndexChanged,
        ),
      ),
    );
  }
}

class _GenerateButton extends ConsumerWidget {
  const _GenerateButton();

  @override
  Widget build(BuildContext context, ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    // return FloatingActionButton(
    //   onPressed: () {

    // },);
    return FloatingActionButton(
      tooltip: 'Generar Documento',
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
          : Icon(Icons.create_rounded),
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
          width: 300,
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
          width: 300,
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

class _DetallesAdicionales extends ConsumerWidget {
  const _DetallesAdicionales();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    // final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final fecha = newDocumentState.fechaInicioRelacionLaboral.value;
    final fechaTxt = fecha != null
        ? AppDateUtils.getCustomFormattedDate(fecha)
        : 'Fecha no seleccionada';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detalles adicionales del caso',
          style: textTheme.titleLarge,
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.spaceEvenly,
            children: [
              AdvancedAutocompleteTextFieldOverlay(
                preferencesKey: 'tribunal',
                width: 200,
                labelText: 'TRIBUNAL',
                onChanged:
                    ref.read(documentFormProvider.notifier).onTribunalChanged,
                errorMessage: newDocumentState.isFormPosted
                    ? newDocumentState.tribunal.errorMessage
                    : null,
              ),
              DateTimeEntryCustom(
                title: 'Fecha Inicio relación laboral',
                onFechaChanged: ref
                    .read(documentFormProvider.notifier)
                    .onFechaInicioRelacionLaboralChanged,
                errorMessage: newDocumentState.isFormPosted
                    ? newDocumentState.fechaInicioRelacionLaboral.errorMessage
                    : null,
                fecha: newDocumentState.fechaInicioRelacionLaboral.value,
              ),
              Text(fechaTxt),
              // DateTimeEntryCustom(
              //   title: 'Fecha Termino relación laboral',
              //   onFechaChanged: ref
              //       .read(documentFormProvider.notifier)
              //       .onFechaTerminoRelacionLaboralChanged,
              //   errorMessage: newDocumentState.isFormPosted
              //       ? newDocumentState.fechaTerminoRelacionLaboral.errorMessage
              //       : null,
              //   fecha: newDocumentState.fechaTerminoRelacionLaboral.value,
              // ),
            ],
          ),
        ),
      ],
    );
  }
}
