import 'package:animate_do/animate_do.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';
import '../../../../core/presentation/presentation.dart';
import '../../../credits/presentation/widgets/widgets.dart';
import '../../../shared/shared.dart';
import '../providers/forms/document_form_03_provider.dart';
import '../widgets/widgets.dart';



final _tabsView = const [
  _Information(),
  _DetallesAdicionales(),
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
        Icon(Icons.request_page_outlined),
        SizedBox(width: 4),
        Text('Compensaciones'),
      ],
    ),
  ),
];
class NewDocument03Screen extends ConsumerStatefulWidget {
  const NewDocument03Screen({super.key});
  static const path = 'new-document-03';
  static const title = 'Plantilla nro 3';
  static const description =
      'DDA_recon Rla Lab Autodespido nulidad SIN solidaria Daño moral.docx';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument03ScreenState();
}

class _NewDocument03ScreenState extends ConsumerState<NewDocument03Screen>
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
            .read(documentForm03Provider.notifier)
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
    // Sincronizar el estado con TabController
    ref.listen(
      documentForm03Provider.select((state) => state.selectedIndex),
      (previous, next) {
        if (_tabController.index != next) {
          _tabController.animateTo(next);
        }
      },
    );

    ref.listen(
      documentForm03Provider,
      (previous, next) {
        if (next.errorMessage.isEmpty) return;
        AppErrorsUtils.onError(context, next.errorMessage);
        // quiero colocar el mensaje de error del state en ''
        // otra vez, para que vuelva a mostrar el error
        // solo cuando vuelva a pasar
        ref.read(documentForm03Provider.notifier).resetError();
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
                   child: Text(NewDocument03Screen.description),
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
    final newDocumentState = ref.watch(documentForm03Provider);
    
    return FloatingActionButton.small(
      tooltip: 'Generar Documento',
      onPressed: newDocumentState.isPosting
          ? null
          : () {
              ref.read(documentForm03Provider.notifier).onFormSubmit().then(
                (document) {
                  if (document != null) {
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
    final newDocumentState = ref.watch(documentForm03Provider);

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
        _InformacionDemandadoPrincipal(ref: ref, newDocumentState: newDocumentState),
        SizedBox(height: 5),
        _InformacionDemandadoSolidario(ref: ref, newDocumentState: newDocumentState),
        SizedBox(height: 5),
        //_InformacionRepresentanteLegal(),
        _InformacionRepresentanteLegalPrincipal(
            ref: ref, newDocumentState: newDocumentState),
        SizedBox(height: 5),
        _InformacionRepresentanteLegalSolidario(
            ref: ref, newDocumentState: newDocumentState),
      ],
    );
  }
}

class _InformacionRepresentanteLegalPrincipal extends StatelessWidget {
  const _InformacionRepresentanteLegalPrincipal({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm03State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Representante Legal Demandado Principal',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_representante_legal',
          initialValue: newDocumentState.representanteLegalPrincipalFullName.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onRepresentanteLegalPrincipalFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalPrincipalFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_representante_legal',
          initialValue: newDocumentState.representanteLegalPrincipalRut.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onRepresentanteLegalPrincipalRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalPrincipalRut.errorMessage
              : null,
        ),
        GenderSelector(
          selectedGender: newDocumentState.representanteLegalPrincipalGender,
          onGenderChanged: ref
              .read(documentForm03Provider.notifier)
              .onRepresentanteLegalPrincipalGenderChanged,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Dirección demandado principal',
          preferencesKey: 'domicilio_empresa',
          initialValue: newDocumentState.representanteLegalPrincipalDomicilio.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onRepresentanteLegalPrincipalDomicilioChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalPrincipalDomicilio.errorMessage
              : null,
        ),
      ],
    );
  }
}
class _InformacionRepresentanteLegalSolidario extends StatelessWidget {
  const _InformacionRepresentanteLegalSolidario({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm03State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Representante Legal Demandado Solidario',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 300,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_representante_legal',
          initialValue: newDocumentState.representanteLegalSolidarioFullName.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onRepresentanteLegalSolidarioFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalSolidarioFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_representante_legal',
          initialValue: newDocumentState.representanteLegalSolidarioRut.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onRepresentanteLegalSolidarioRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalSolidarioRut.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Dirección demandado Solidario',
          preferencesKey: 'domicilio_empresa',
          initialValue: newDocumentState.representanteLegalSolidarioDomicilio.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onRepresentanteLegalSolidarioDomicilioChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.representanteLegalSolidarioDomicilio.errorMessage
              : null,
        ),
      ],
    );
  }
}


class _InformacionDemandadoPrincipal extends StatelessWidget {
  const _InformacionDemandadoPrincipal({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm03State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Demandado Principal',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_demandado',
          initialValue: newDocumentState.demandadoPrincipalFullName.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onDemandadoPrincipalFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoPrincipalFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_demandado',
          initialValue: newDocumentState.demandadoPrincipalRut.value,
          onChanged:
              ref.read(documentForm03Provider.notifier).onDemandadoPrincipalRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoPrincipalRut.errorMessage
              : null,
        ),
      ],
    );
  }
}
class _InformacionDemandadoSolidario extends StatelessWidget {
  const _InformacionDemandadoSolidario({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentForm03State newDocumentState;

  @override
  Widget build(BuildContext context) {
    return CardModelInformation(
      title: 'Demandado Solidario',
      children: [
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Nombre Completo',
          preferencesKey: 'nombre_demandado',
          initialValue: newDocumentState.demandadoSolidarioFullName.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onDemandadoSolidarioFullNameChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoSolidarioFullName.errorMessage
              : null,
        ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 200,
          labelText: 'Rut/CI',
          preferencesKey: 'rut_demandado',
          initialValue: newDocumentState.demandadoSolidarioRut.value,
          onChanged:
              ref.read(documentForm03Provider.notifier).onDemandadoSolidarioRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandadoSolidarioRut.errorMessage
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
  final DocumentForm03State newDocumentState;

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
              .read(documentForm03Provider.notifier)
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
              ref.read(documentForm03Provider.notifier).onAbogado2RutChanged,
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
              ref.read(documentForm03Provider.notifier).onAbogado2EmailChanged,
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
  final DocumentForm03State newDocumentState;

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
              .read(documentForm03Provider.notifier)
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
              ref.read(documentForm03Provider.notifier).onAbogado1RutChanged,
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
              ref.read(documentForm03Provider.notifier).onAbogado1EmailChanged,
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
  final DocumentForm03State newDocumentState;

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
              .read(documentForm03Provider.notifier)
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
              ref.read(documentForm03Provider.notifier).onDemandanteRutChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteRut.errorMessage
              : null,
        ),
        GenderSelector(
          selectedGender: newDocumentState.demandanteGender,
          onGenderChanged: ref
              .read(documentForm03Provider.notifier)
              .onDemandanteGenderChanged,
        ),
        // EstadoCivilDropdown(
        //   estadoCivilInicial: newDocumentState.demandanteEstadoCivil,
        //   gender: newDocumentState.demandanteGender,
        //   onChanged: ref
        //       .read(documentForm03Provider.notifier)
        //       .onDemandanteEstadoCivilChanged,
        // ),
        AdvancedAutocompleteTextFieldOverlay(
          width: 180,
          labelText: 'Nacionalidad',
          preferencesKey: 'nacionalidad',
          initialValue: newDocumentState.demandanteNacionalidad.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onDemandanteNacionalidadChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteNacionalidad.errorMessage
              : null,
        ),
        // Dirección demandante
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Dirección demandante',
          preferencesKey: 'direccion_demandante',
          initialValue: newDocumentState.demandanteDireccion.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onDemandanteDireccionChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.demandanteDireccion.errorMessage
              : null,
        ),
        // Región Demandante
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Región demandante',
          preferencesKey: 'region',
          initialValue: newDocumentState.regionDemandante.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onRegionDemandanteChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.regionDemandante.errorMessage
              : null,
        ),
        // Comuna Demandante
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Comuna demandante',
          preferencesKey: 'comuna',
          initialValue: newDocumentState.comunaDemandante.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onComunaDemandanteChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.comunaDemandante.errorMessage
              : null,
        ),
        // Calle Dirección Demandante
        AdvancedAutocompleteTextFieldOverlay(
          width: 400,
          labelText: 'Calle dirección demandante',
          preferencesKey: 'calle',
          initialValue: newDocumentState.calleDireccionDemandante.value,
          onChanged: ref
              .read(documentForm03Provider.notifier)
              .onCalleDireccionDemandanteChanged,
          errorMessage: newDocumentState.isFormPosted
              ? newDocumentState.calleDireccionDemandante.errorMessage
              : null,
        ),
      ],
    );
  }
}

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
    final newDocumentState = ref.watch(documentForm03Provider);
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
                            .read(documentForm03Provider.notifier)
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
                            .read(documentForm03Provider.notifier)
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

                          final bool isBeforeFechaInicio = day.isBefore(newDocumentState
                                  .fechaInicioRelacionLaboral.value ??
                              DateTime.now());

                          return !day.isAfter(DateTime.now()) && !isBeforeFechaInicio;
                        },
                        onFechaChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onFechaTerminoRelacionLaboralChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .fechaTerminoRelacionLaboral.errorMessage
                            : null,
                        fecha:
                            newDocumentState.fechaTerminoRelacionLaboral.value,
                      ),
                      DateTimeEntryCustom(
                        title: 'Fecha de autodespido',
                        selectableDayPredicate: (day) {

                          final bool isBeforeFechaInicio = day.isBefore(
                            newDocumentState.fechaInicioRelacionLaboral.value
                            ?? DateTime.now());

                          final bool isAfterFechaTermino = day.isAfter(
                            newDocumentState.fechaTerminoRelacionLaboral.value
                            ?? DateTime.now());

                          return !isAfterFechaTermino && !isBeforeFechaInicio;
                        },
                        onFechaChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onFechaAutodespidoChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.fechaAutodespido.errorMessage
                            : null,
                        fecha:
                            newDocumentState.fechaAutodespido.value,
                      ),
                      DateTimeEntryCustom(
                        title: 'Fecha de reclamo DT',
                        selectableDayPredicate: (day) {

                          final bool isBeforeFechaInicio = day.isBefore(
                            newDocumentState.fechaInicioRelacionLaboral.value
                            ?? DateTime.now());

                          final bool isAfterFechaTermino = day.isAfter(
                            newDocumentState.fechaTerminoRelacionLaboral.value
                            ?? DateTime.now());

                          return !isAfterFechaTermino && !isBeforeFechaInicio;
                        },
                        onFechaChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onFechaReclamoDtChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.fechaReclamoDt.errorMessage
                            : null,
                        fecha:
                            newDocumentState.fechaReclamoDt.value,
                      ),
                      DateTimeEntryCustom(
                        title: 'Fecha de comparendo DT',
                        selectableDayPredicate: (day) {

                          final bool isBeforeFechaInicio = day.isBefore(
                            newDocumentState.fechaInicioRelacionLaboral.value
                            ?? DateTime.now());

                          final bool isAfterFechaTermino = day.isAfter(
                            newDocumentState.fechaTerminoRelacionLaboral.value
                            ?? DateTime.now());

                          return !isAfterFechaTermino && !isBeforeFechaInicio;
                        },
                        onFechaChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onFechaComparendoDtChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.fechaComparendoDt.errorMessage
                            : null,
                        fecha:
                            newDocumentState.fechaComparendoDt.value,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'cargo_demandante',
                        width: 300,
                        labelText: 'CARGO DEL DEMANDANTE',
                        initialValue: newDocumentState.cargoDemandante.value,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onCargoDemandanteChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.cargoDemandante.errorMessage
                            : null,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'comuna',
                        width: 300,
                        labelText: 'COMUNA DEMANDADO SOLIDARIO',
                        initialValue: newDocumentState.comunaDemandadoSolidario.value,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onComunaDemandadoSolidarioChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.comunaDemandadoSolidario.errorMessage
                            : null,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'tipo_contrato',
                        width: 300,
                        labelText: 'TIPO DE CONTRATO',
                        initialValue: newDocumentState.tipoContrato.value,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onTipoContratoChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.tipoContrato.errorMessage
                            : null,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'horario_jornada_trabajo',
                        width: 300,
                        labelText: 'HORARIO JORNADA DE TRABAJO',
                        initialValue: newDocumentState.horarioJornadaTrabajo.value,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onHorarioJornadaTrabajoChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.horarioJornadaTrabajo.errorMessage
                            : null,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'tipo_afp_trabajador',
                        width: 300,
                        labelText: 'TIPO DE AFP TRABAJADOR',
                        initialValue: newDocumentState.tipoAFP.value,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onTipoAFPChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.tipoAFP.errorMessage
                            : null,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'causal_termino',
                        width: 300,
                        labelText: 'CAUSAL DE TERMINO',
                        initialValue: newDocumentState.causalTermino.value,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onCausalTerminoChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.causalTermino.errorMessage
                            : null,
                      ),
                      AdvancedAutocompleteTextFieldOverlay(
                        preferencesKey: 'periodo_impago_imposiciones',
                        width: 300,
                        labelText: 'PERIODO IMPAGO IMPOSICIONES',
                        initialValue: newDocumentState.periodoImposiciones.value,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onPeriodoImposicionesChanged,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.periodoImposiciones.errorMessage
                            : null,
                      ),
                      CustomNumericTextField(
                        labelText: 'FERIADO LEGAL DIAS',
                        isNumeric: true,
                        initialValue: newDocumentState.feriadoLegalDias.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.feriadoLegalDias.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onFeriadoLegalDiasChanged,
                      ),
                     
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 25),
              Column(
                children: [
                  CustomLargeTextField(
                    labelText: 'LABORES DESARROLLADAS\nPOR EL TRABAJADOR',
                    height: altura * factorAltura,
                    initialValue: newDocumentState.laboresTrabajador.value,
                    onChanged: ref
                        .read(documentForm03Provider.notifier)
                        .onLaboresTrabajadorChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState.laboresTrabajador.errorMessage
                        : null,
                  ),
                  const SizedBox(height: 30),
                  CustomLargeTextField(
                    labelText:
                        'SERVICIOS PRESTADOS\nPOR LA PRINCIPAL\nA LA SOLIDARIA',
                    height: altura * factorAltura,
                    initialValue:
                        newDocumentState.serviciosPrestados.value,
                    onChanged: ref
                        .read(documentForm03Provider.notifier)
                        .onServiciosPrestadosChanged,
                    errorMessage: newDocumentState.isFormPosted
                        ? newDocumentState.serviciosPrestados.errorMessage
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
    final newDocumentState = ref.watch(documentForm03Provider);
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
                'Compensaciones',
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
                        labelText: 'MONTO DAÑO MORAL',
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true, 
                        initialValue: newDocumentState.montoDanioMoral.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.montoDanioMoral.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onMontoDanioMoralChanged,
                      ),
                      CustomNumericTextField(
                        labelText: 'REMUNERACIÓN',
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true, 
                        initialValue: newDocumentState.remuneracion.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.remuneracion.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onRemuneracionChanged,
                      ),
                      CustomNumericTextField(
                        labelText: 'REMUNERACIÓN POR 50%',
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true, 
                        initialValue: newDocumentState.remuneracionPor50.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.remuneracionPor50.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onRemuneracionPor50Changed,
                      ),
                      CustomNumericTextField(
                        labelText: 'REMUNERACIÓN POR FERIADO LEGAL',
                        width: 300,
                        isNumeric: true,
                        allowDecimals: true,
                        isCurrency: true, 
                        initialValue: newDocumentState.montoFeriadoLegal.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.montoFeriadoLegal.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentForm03Provider.notifier)
                            .onMontoFeriadoLegalChanged,
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
                      'Documentos',
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
                                  .read(documentForm03Provider.notifier)
                                  .onDocumentoAdicionalChanged,
                            ),
                            IconButton(
                              tooltip: 'Eliminar item',
                              icon: const Icon(Icons.delete_forever_rounded),
                              onPressed: () {
                                ref
                                    .read(documentForm03Provider.notifier)
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
                                .read(documentForm03Provider.notifier)
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

