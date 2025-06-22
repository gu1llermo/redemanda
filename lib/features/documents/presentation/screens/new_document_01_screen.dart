import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:redemanda/features/shared/shared.dart';
import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../../../credits/presentation/widgets/widgets.dart';
import '../providers/forms/document_form_01_provider.dart';
import '../widgets/widgets.dart';

final _tabsView = const [
  _Information(),
  _DetallesAdicionales(),
  _Danios(),
  _Compensaciones(),
];

final _tabs = const [
  Tab(
    child: Row(
      children: [
        Icon(Icons.info_outline_rounded),
        SizedBox(width: 4),
        Text('Información'),
      ],
    ),
  ),
  Tab(
    child: Row(
      children: [
        Icon(Icons.details_rounded),
        SizedBox(width: 4),
        Text('Detalles'),
      ],
    ),
  ),
  Tab(
    child: Row(
      children: [
        Icon(Icons.broken_image),
        SizedBox(width: 4),
        Text('Daños'),
      ],
    ),
  ),
  Tab(
    child: Row(
      children: [
        Icon(Icons.request_page_outlined),
        SizedBox(width: 4),
        Text('Compensaciones'),
      ],
    ),
  ),
];

class NewDocument01Screen extends ConsumerStatefulWidget {
  const NewDocument01Screen({super.key});
  static const path = 'new-document-01';
  static const title = 'Plantilla nro 1';
  static const description = 'Auto despido con accidente y daño moral';

  @override
  ConsumerState<NewDocument01Screen> createState() => _NewDocumentScreenState();
}

class _NewDocumentScreenState extends ConsumerState<NewDocument01Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);

    // Sincronizar TabController con el estado
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        ref
            .read(documentForm01Provider.notifier)
            .onSelectedIndexChanged(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final newDocumentState = ref.watch(documentFormProvider);

    // Sincronizar el estado con TabController
    ref.listen(
      documentForm01Provider.select((state) => state.selectedIndex),
      (previous, next) {
        if (_tabController.index != next) {
          _tabController.animateTo(next);
        }
      },
    );

    ref.listen(
      documentForm01Provider,
      (previous, next) {
        if (next.errorMessage.isEmpty) return;
        AppErrorsUtils.onError(context, next.errorMessage);
        // quiero colocar el mensaje de error del state en ''
        // otra vez, para que vuelva a mostrar el error
        // solo cuando vuelva a pasar
        ref.read(documentForm01Provider.notifier).resetError();
      },
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               Expanded(
                 child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                   child: Text(NewDocument01Screen.description),
                 ),
               ),
              const UserCreditsWidget(),
            ],
          ),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: _tabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: _tabsView,
        ),
        floatingActionButton: _GenerateButton(),
      ),
    );
  }
}

class _GenerateButton extends ConsumerWidget {
  const _GenerateButton();

  @override
  Widget build(BuildContext context, ref) {
    final newDocumentState = ref.watch(documentForm01Provider);
    // return FloatingActionButton(
    //   onPressed: () {

    // },);
    return FloatingActionButton.small(
      tooltip: 'Generar Documento',
      onPressed: newDocumentState.isPosting
          ? null
          : () {
              ref.read(documentForm01Provider.notifier).onFormSubmit().then(
                (document) {
                  if (document != null) {
                    // aquí tengo que pensar qué hacer
                    if (!context.mounted) return;

                    AppErrorsUtils.onSucces(
                      context,
                      'Documento generado correctamente!',
                      Row(
                        children: [
                          if (!kIsWeb)
                            TextButton(
                              onPressed: () {
                                NotificationService()
                                    .dismissCurrentNotification();
                                FileUtils.openWithDefaultApp(
                                  context: context,
                                  fileBytes: document.docxFile,
                                  fileExtension: 'docx', // sin el punto
                                );
                              },
                              child: const Text(
                                'Ver',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              NotificationService()
                                  .dismissCurrentNotification();
                              context.pop();
                            },
                            child: const Text(
                              'Salir',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );

                    //   context.pop();
                  }
                },
              );
            },
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

// El resto de las clases (_Information, _DetallesAdicionales, _Danios, _Compensaciones)
// permanecen sin cambios

class _Information extends ConsumerStatefulWidget {
  const _Information();

  @override
  ConsumerState<_Information> createState() => _InformationState();
}

class _InformationState extends ConsumerState<_Information>
    with AutomaticKeepAliveClientMixin, KeepPageAliveMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newDocumentState = ref.watch(documentForm01Provider);

    return ListView(
      padding: const EdgeInsets.only(
        bottom: 100,
        left: 5,
        right: 5,
      ),
      children: [
        SizedBox(height: 5),
        // _InformacionDemandante(),
        _InformacionDemandante(ref: ref, newDocumentState: newDocumentState),
        SizedBox(height: 5),
        //_InformacionAbogado1(),
        _InformacionAbogado1(ref: ref, newDocumentState: newDocumentState),
        SizedBox(height: 5),
        //_InformacionAbogado2(),
        _InformacionAbogado2(ref: ref, newDocumentState: newDocumentState),
        SizedBox(height: 5),
        //_InformacionDemandado(),
        _InformacionDemandado(ref: ref, newDocumentState: newDocumentState),
        SizedBox(height: 5),
        //_InformacionRepresentanteLegal(),
        _InformacionRepresentanteLegal(
            ref: ref, newDocumentState: newDocumentState),
        //SizedBox(height: 40),
        // _SubmitButton()
      ],
    );
  }
}

class _InformacionRepresentanteLegal extends StatelessWidget {
  const _InformacionRepresentanteLegal({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm01State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Representante Legal',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_representante_legal',
          initialValue: newDocumentState.representanteLegalFullName.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onRepresentanteLegalFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_representante_legal',
          initialValue: newDocumentState.representanteLegalRut.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onRepresentanteLegalRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalRut.errorMessage
              : null,
        ),
        GenderSelector(
          selectedGender: newDocumentState.representanteLegalGender,
          onGenderChanged: ref
              .read(documentForm01Provider.notifier)
              .onRepresentanteLegalGenderChanged,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Domicilio Empresa',
          preferencesKey: 'domicilio_empresa',
          initialValue: newDocumentState.representanteLegalDomicilio.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onRepresentanteLegalDomicilioChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalDomicilio.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionDemandado extends StatelessWidget {
  const _InformacionDemandado({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm01State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Demandado',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_demandado',
          initialValue: newDocumentState.demandadoFullName.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onDemandadoFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_demandado',
          initialValue: newDocumentState.demandadoRut.value,
          onChanged:
              ref.read(documentForm01Provider.notifier).onDemandadoRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoRut.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionAbogado2 extends StatelessWidget {
  const _InformacionAbogado2({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm01State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Abogado 2',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_abogado_2',
          initialValue: newDocumentState.abogado2FullName.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onAbogado2FullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado2FullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_abogado_2',
          initialValue: newDocumentState.abogado2Rut.value,
          onChanged:
              ref.read(documentForm01Provider.notifier).onAbogado2RutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado2Rut.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Correo',
          preferencesKey: 'correo_abogado_2',
          initialValue: newDocumentState.abogado2Email.value,
          onChanged:
              ref.read(documentForm01Provider.notifier).onAbogado2EmailChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado2Email.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionAbogado1 extends StatelessWidget {
  const _InformacionAbogado1({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm01State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Abogado 1',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_abogado_1',
          initialValue: newDocumentState.abogado1FullName.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onAbogado1FullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado1FullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_abogado_1',
          initialValue: newDocumentState.abogado1Rut.value,
          onChanged:
              ref.read(documentForm01Provider.notifier).onAbogado1RutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado1Rut.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Correo',
          preferencesKey: 'correo_abogado_1',
          initialValue: newDocumentState.abogado1Email.value,
          onChanged:
              ref.read(documentForm01Provider.notifier).onAbogado1EmailChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.abogado1Email.errorMessage
              : null,
        ),
      ],
    );
  }
}

class _InformacionDemandante extends StatelessWidget {
  const _InformacionDemandante({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm01State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Demandante',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_demandante',
          initialValue: newDocumentState.demandanteFullName.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onDemandanteFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_demandante',
          initialValue: newDocumentState.demandanteRut.value,
          onChanged:
              ref.read(documentForm01Provider.notifier).onDemandanteRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteRut.errorMessage
              : null,
        ),
        GenderSelector(
          selectedGender: newDocumentState.demandanteGender,
          onGenderChanged: ref
              .read(documentForm01Provider.notifier)
              .onDemandanteGenderChanged,
        ),
        EstadoCivilDropdown(
          estadoCivilInicial: newDocumentState.demandanteEstadoCivil,
          gender: newDocumentState.demandanteGender,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onDemandanteEstadoCivilChanged,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 180,
          labelText: 'Nacionalidad',
          preferencesKey: 'nacionalidad',
          initialValue: newDocumentState.demandanteNacionalidad.value,
          onChanged: ref
              .read(documentForm01Provider.notifier)
              .onDemandanteNacionalidadChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteNacionalidad.errorMessage
              : null,
        ),
      ],
    );
  }
}



// class _NextButton extends ConsumerWidget {
//   const _NextButton(this.nroPaginas);
//   final int nroPaginas;

//   @override
//   Widget build(BuildContext context, ref) {
//     final newDocumentState = ref.watch(documentForm01Provider);
//     final indiceActual = newDocumentState.selectedIndex;

//     return indiceActual < nroPaginas - 1
//         ? FloatingActionButton(
//             tooltip: 'Siguiente',
//             heroTag: 'next',
//             onPressed: () {
//               ref.read(documentForm01Provider.notifier).incrementarIndex();
//             },
//             child: Icon(Icons.arrow_forward_rounded),
//           )
//         : SizedBox(width: 10);
//   }
// }

// class _PreviusButton extends ConsumerWidget {
//   const _PreviusButton(this.nroPaginas);
//   final int nroPaginas;

//   @override
//   Widget build(BuildContext context, ref) {
//     final newDocumentState = ref.watch(documentForm01Provider);
//     final indiceActual = newDocumentState.selectedIndex;

//     return indiceActual > 0
//         ? Padding(
//             padding: const EdgeInsets.only(left: 30),
//             child: FloatingActionButton(
//               tooltip: 'Anterior',
//               heroTag: 'previus',
//               onPressed: () {
//                 ref.read(documentForm01Provider.notifier).decrementarIndex();
//               },
//               child: Icon(Icons.arrow_back_rounded),
//             ),
//           )
//         : SizedBox(width: 10);
//   }
// }

class _DetallesAdicionales extends ConsumerStatefulWidget {
  const _DetallesAdicionales();

  @override
  ConsumerState<_DetallesAdicionales> createState() =>
      _DetallesAdicionalesState();
}

class _DetallesAdicionalesState extends ConsumerState<_DetallesAdicionales>
    with AutomaticKeepAliveClientMixin, KeepPageAliveMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newDocumentState = ref.watch(documentForm01Provider);
    // final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // final remuneracion =
    //     "\$${StringUtils.formatToNumber(newDocumentState.remuneracion.value)}";
    final size = MediaQuery.sizeOf(context);
    final altura = size.height;
    final ancho = size.width;
    final factorAltura = ancho > 600 ? 0.2 : 0.3;
    return ListView(
      padding: const EdgeInsets.only(
        bottom: 60,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                'Detalles adicionales del caso',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 5,
                    spacing: 20,
                    children: [
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'tribunal',
                        width: 200,
                        labelText: 'TRIBUNAL',
                        initialValue: newDocumentState.tribunal.value,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onTribunalChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.tribunal.errorMessage
                            : null,
                      ),
                      DateTimeEntryCustom(
                        title: 'Fecha Inicio relación laboral',
                        selectableDayPredicate: (day) {
                          // Retorna true solo para días que no sean posteriores a hoy
                          return !day.isAfter(DateTime.now());
                        },
                        onFechaChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onFechaInicioRelacionLaboralChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .fechaInicioRelacionLaboral.errorMessage
                            : null,
                        fecha:
                            newDocumentState.fechaInicioRelacionLaboral.value,
                      ),
                      DateTimeEntryCustom(
                        title: 'Fecha Termino relación laboral',
                        selectableDayPredicate: (day) {
                          // Retorna true solo para días que no sean posteriores a hoy

                          final bool isBefore = day.isBefore(newDocumentState
                                  .fechaInicioRelacionLaboral.value ??
                              DateTime.now());

                          return !day.isAfter(DateTime.now()) && !isBefore;
                        },
                        onFechaChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onFechaTerminoRelacionLaboralChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .fechaTerminoRelacionLaboral.errorMessage
                            : null,
                        fecha:
                            newDocumentState.fechaTerminoRelacionLaboral.value,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'cargo_trabajador',
                        width: 300,
                        labelText: 'CARGO DEL TRABAJADOR',
                        initialValue: newDocumentState.cargoTrabajador.value,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onCargoTrabajadorChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.cargoTrabajador.errorMessage
                            : null,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'tipo_contrato',
                        width: 300,
                        labelText: 'TIPO DE CONTRATO',
                        initialValue: newDocumentState.tipoContrato.value,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onTipoContratoChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.tipoContrato.errorMessage
                            : null,
                      ),
                      CustomNumericTextField(
                        labelText: 'HORAS SEMANALES',
                        isNumeric: true,
                        initialValue: newDocumentState.horasSemanales.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.horasSemanales.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onHorasSemanalesChanged,
                      ),
                      CustomNumericTextField(
                        labelText: 'REMUNERACIÓN',
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true, // Enable currency formatting
                        initialValue: newDocumentState.remuneracion.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.remuneracion.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onRemuneracionChanged,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Divider(),
              Text(
                'Detalles del accidente',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  runSpacing: 10,
                  spacing: 20,
                  children: [
                    DateTimeEntryCustom(
                      title: 'Fecha del accidente laboral',
                      selectableDayPredicate: (day) {
                        final bool isBefore = day.isBefore(
                            newDocumentState.fechaInicioRelacionLaboral.value ??
                                DateTime.now());
                        final bool isAfter = day.isAfter(newDocumentState
                                .fechaTerminoRelacionLaboral.value ??
                            newDocumentState.fechaInicioRelacionLaboral.value ??
                            DateTime.now());

                        return !isBefore && !isAfter;
                      },
                      onFechaChanged: ref
                          .read(documentForm01Provider.notifier)
                          .onFechaAccidenteLaboralChanged,
                      errorMessage: newDocumentState.isFormPosted
                          ? newDocumentState.fechaAccidenteLaboral.errorMessage
                          : null,
                      fecha: newDocumentState.fechaAccidenteLaboral.value,
                    ),
                    SelectTimeEntryCustom(
                      title: 'Hora del accidente',
                      onHoraChanged: ref
                          .read(documentForm01Provider.notifier)
                          .onHoraAccidenteChanged,
                      errorMessage: newDocumentState.isFormPosted
                          ? newDocumentState.horaAccidente.errorMessage
                          : null,
                      hora: newDocumentState.horaAccidente.value,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  CustomLargeTextField(
                    labelText: 'Relato del accidente (Extenso)',
                    height: altura * factorAltura,
                    initialValue: newDocumentState.relatoAccidenteExtenso.value,
                    onChanged: ref
                        .read(documentForm01Provider.notifier)
                        .onRelatoAccidenteExtensoChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState.relatoAccidenteExtenso.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 5),
                  CustomLargeTextField(
                    labelText:
                        'Relato hechos posteriores al accidente (Extenso)',
                    height: altura * factorAltura,
                    initialValue:
                        newDocumentState.relatoHechosPosteriores.value,
                    onChanged: ref
                        .read(documentForm01Provider.notifier)
                        .onRelatoHechosPosterioresChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState.relatoHechosPosteriores.errorMessage
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class _Danios extends ConsumerStatefulWidget {
  const _Danios();

  @override
  ConsumerState<_Danios> createState() => _DaniosState();
}

class _DaniosState extends ConsumerState<_Danios>
    with AutomaticKeepAliveClientMixin, KeepPageAliveMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newDocumentState = ref.watch(documentForm01Provider);
    final textTheme = Theme.of(context).textTheme;
    // final montoADemandar =
    //     "\$${StringUtils.formatToNumber(newDocumentState.montoADemandar.value)}";
    // final porcentajeIncapacidad =
    //     "${newDocumentState.porcentajeIncapacidad.value}%";
    final altura = MediaQuery.sizeOf(context).height;

    return ListView(
      padding: const EdgeInsets.only(
        bottom: 60,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                'Daños y perjuicios',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 5,
                    spacing: 20,
                    children: [
                      CustomNumericTextField(
                        width: 250,
                        labelText: 'Porcentaje de incapacidad',
                        isNumeric: true,
                        isPercentage: true, // Enable percentage formatting
                        initialValue:
                            newDocumentState.porcentajeIncapacidad.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .porcentajeIncapacidad.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onPorcentajeIncapacidadChanged,
                      ),
                      CustomNumericTextField(
                        labelText: 'Monto a demandar',
                        width: 250,
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true, // Enable currency formatting
                        initialValue: newDocumentState.montoADemandar.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.montoADemandar.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onMontoADemandarChanged,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Column(
                children: [
                  CustomLargeTextField(
                    labelText: 'Relato daños estéticos',
                    height: altura * 0.23,
                    initialValue: newDocumentState.relatoDaniosEsteticos.value,
                    onChanged: ref
                        .read(documentForm01Provider.notifier)
                        .onRelatoDaniosEsteticosChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState.relatoDaniosEsteticos.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 5),
                  CustomLargeTextField(
                    labelText: 'Daño que tiene el actor',
                    hintText:
                        'En virtud de lo anterior, es menester hacer presente S.S., que hasta el día de hoy ${newDocumentState.demandanteGender.donCortesia()} ${newDocumentState.demandanteFullName.value} tiene una (daño que tiene el actor)',
                    height: altura * 0.2,
                    initialValue: newDocumentState.danioActor.value,
                    onChanged: ref
                        .read(documentForm01Provider.notifier)
                        .onDanioActorChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState.danioActor.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 5),
                  CustomLargeTextField(
                    labelText: 'Daño del trabajador',
                    height: altura * 0.1,
                    initialValue: newDocumentState.danioTrabajador.value,
                    onChanged: ref
                        .read(documentForm01Provider.notifier)
                        .onDanioTrabajadorChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState.danioTrabajador.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 5),
                  CustomLargeTextField(
                    labelText: 'Medidas necesarias empresa demandada',
                    hintText:
                        'En definitiva, la empresa demandada no tomó todas las medidas necesarias, tales como:',
                    height: altura * 0.15,
                    initialValue: newDocumentState
                        .medidasNecesariasEmpresaDemandada.value,
                    onChanged: ref
                        .read(documentForm01Provider.notifier)
                        .onMedidasNecesariasEmpresaDemandadaChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState
                            .medidasNecesariasEmpresaDemandada.errorMessage
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}

class _Compensaciones extends ConsumerStatefulWidget {
  const _Compensaciones();

  @override
  ConsumerState<_Compensaciones> createState() => _CompensacionesState();
}

class _CompensacionesState extends ConsumerState<_Compensaciones>
    with AutomaticKeepAliveClientMixin, KeepPageAliveMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final newDocumentState = ref.watch(documentForm01Provider);
    // final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    // final montoRemuneracionSegunEmpleador =
    //     "\$${StringUtils.formatToNumber(newDocumentState.montoRemuneracionSegunEmpleador.value)}";
    // final montoRemuneracionArt172 =
    //     "\$${StringUtils.formatToNumber(newDocumentState.montoRemuneracionArt172.value)}";

    final bool showAddIconItem = newDocumentState.documentosAdicionalesAIngresar
        .every((element) => element.isNotEmpty);

    return ListView(
      padding: const EdgeInsets.only(
        bottom: 60,
      ),
      physics: ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Text(
                'Cálculo de remuneración',
                style: textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 5,
                    spacing: 20,
                    children: [
                      CustomNumericTextField(
                        width: 400,
                        labelText: 'Monto remuneración empleador',
                        hintText: 'Monto de remuneración según empleador',
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true,
                        initialValue: newDocumentState
                            .montoRemuneracionSegunEmpleador.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .montoRemuneracionSegunEmpleador.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onMontoRemuneracionSegunEmpleadorChanged,
                      ),
                      CustomNumericTextField(
                        labelText: 'Monto remuneración art. 172',
                        hintText: 'Monto de remuneración según el artículo 172',
                        width: 400,
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true,
                        initialValue:
                            newDocumentState.montoRemuneracionArt172.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .montoRemuneracionArt172.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm01Provider.notifier)
                            .onMontoRemuneracionArt172Changed,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEGUNDO OTROSÍ (Lista de documentos a ingresar en la demanda)',
                    ),
                    const SizedBox(height: 5),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: newDocumentState
                          .documentosAdicionalesAIngresar.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            CustomDocumentoAdicionalTextField(
                              hintText: 'Documento a ingresar en la demanda',
                              index: index,
                              initialValue: newDocumentState
                                  .documentosAdicionalesAIngresar[index],
                              onChanged: ref
                                  .read(documentForm01Provider.notifier)
                                  .onDocumentoAdicionalChanged,
                            ),
                            IconButton(
                              tooltip: 'Eliminar item',
                              icon: const Icon(Icons.delete_forever_rounded),
                              onPressed: () {
                                ref
                                    .read(documentForm01Provider.notifier)
                                    .onRemoveDocumentosAdicionalesAIngresar(
                                        index);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    if (showAddIconItem)
                      JelloIn(
                        child: IconButton(
                          tooltip: 'Agregar item',
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            ref
                                .read(documentForm01Provider.notifier)
                                .onAddDocumentosAdicionalesAIngresar();
                          },
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
