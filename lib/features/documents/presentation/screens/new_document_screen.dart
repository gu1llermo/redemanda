import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:redemanda/features/shared/shared.dart';

import '../../../../config/config.dart';
import '../../../../core/core.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class NewDocumentScreen extends ConsumerStatefulWidget {
  const NewDocumentScreen({super.key});

  @override
  ConsumerState<NewDocumentScreen> createState() => _NewDocumentScreenState();
}

class _NewDocumentScreenState extends ConsumerState<NewDocumentScreen> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    final newDocumentState = ref.watch(documentFormProvider);

    final widgetOptions = [
      _Information(),
      _DetallesAdicionales(),
      _Danios(),
      _Compensaciones(),
    ];

    // ref.listen(
    //   documentFormProvider,
    //   (previous, next) {
    //     if (next.errorMessage.isEmpty) return;
    //     AppErrorsUtils.onError(context, next.errorMessage);
    //   },
    // );
    ref.listen(
      documentFormProvider,
      (previous, next) {
        if (next.errorMessage.isEmpty) return;
        AppErrorsUtils.onError(context, next.errorMessage);
      },
    );

    ref.listen(
      documentFormProvider.select((state) => state.selectedIndex),
      (previous, next) {
        // Lógica cuando cambia specificAttribute
        if (next != newDocumentState.selectedIndex) {
          pageController.animateToPage(
            next,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            // curve: Curves.linear,
          );
        }
      },
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Nuevo Documento'),
          actions: [
            _SubmitButton(),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
          child: PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            // physics: const ClampingScrollPhysics(),
            // physics: const BouncingScrollPhysics(),
            // onPageChanged: (index) {
            //   ref
            //       .read(documentFormProvider.notifier)
            //       .onSelectedIndexChanged(index);
            // },
            children: widgetOptions,
          ),
          // child: IndexedStack(
          //   index: newDocumentState.selectedIndex,
          //   children: widgetOptions,
          // ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _PreviusButton(widgetOptions.length),
            _NextButton(widgetOptions.length),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline_rounded),
              label: 'Información',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.details_rounded),
              label: 'Detalles',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.broken_image),
              label: 'Daños',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page_outlined),
              label: 'Compensaciones',
            ),
          ],
          currentIndex: newDocumentState.selectedIndex,
          onTap: (index) {
            // pageController
            //     .animateToPage(
            //   index,
            //   duration: const Duration(milliseconds: 300),
            //   curve: Curves.linear,
            // )
            //     .then(
            //   (value) {
            //     ref
            //         .read(documentFormProvider.notifier)
            //         .onSelectedIndexChanged(index);
            //   },
            // );

            ref
                .read(documentFormProvider.notifier)
                .onSelectedIndexChanged(index);
          },
        ),
      ),
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
    final newDocumentState = ref.watch(documentFormProvider);

    return ListView(
      padding: const EdgeInsets.only(bottom: 40),
      children: [
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
  final DocumentFormState newDocumentState;

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
          initialValue: newDocumentState.representanteLegalRut.value,
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
          initialValue: newDocumentState.representanteLegalDomicilio.value,
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

class _InformacionDemandado extends StatelessWidget {
  const _InformacionDemandado({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentFormState newDocumentState;

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
          initialValue: newDocumentState.demandadoRut.value,
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

class _InformacionAbogado2 extends StatelessWidget {
  const _InformacionAbogado2({
    required this.ref,
    required this.newDocumentState,
  });

  final WidgetRef ref;
  final DocumentFormState newDocumentState;

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
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado2FullNameChanged,
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
              ref.read(documentFormProvider.notifier).onAbogado2RutChanged,
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
              ref.read(documentFormProvider.notifier).onAbogado2EmailChanged,
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
  final DocumentFormState newDocumentState;

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
          onChanged:
              ref.read(documentFormProvider.notifier).onAbogado1FullNameChanged,
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
              ref.read(documentFormProvider.notifier).onAbogado1RutChanged,
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
              ref.read(documentFormProvider.notifier).onAbogado1EmailChanged,
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
  final DocumentFormState newDocumentState;

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
          initialValue: newDocumentState.demandanteRut.value,
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
          initialValue: newDocumentState.demandanteNacionalidad.value,
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
          : () {
              ref.read(documentFormProvider.notifier).onFormSubmit().then(
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

class _NextButton extends ConsumerWidget {
  const _NextButton(this.nroPaginas);
  final int nroPaginas;

  @override
  Widget build(BuildContext context, ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    final indiceActual = newDocumentState.selectedIndex;

    return indiceActual < nroPaginas - 1
        ? FloatingActionButton(
            tooltip: 'Siguiente',
            heroTag: 'next',
            onPressed: () {
              ref.read(documentFormProvider.notifier).incrementarIndex();
            },
            child: Icon(Icons.arrow_forward_rounded),
          )
        : SizedBox(width: 10);
  }
}

class _PreviusButton extends ConsumerWidget {
  const _PreviusButton(this.nroPaginas);
  final int nroPaginas;

  @override
  Widget build(BuildContext context, ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    final indiceActual = newDocumentState.selectedIndex;

    return indiceActual > 0
        ? Padding(
            padding: const EdgeInsets.only(left: 30),
            child: FloatingActionButton(
              tooltip: 'Anterior',
              heroTag: 'previus',
              onPressed: () {
                ref.read(documentFormProvider.notifier).decrementarIndex();
              },
              child: Icon(Icons.arrow_back_rounded),
            ),
          )
        : SizedBox(width: 10);
  }
}

class _SubmitButton extends ConsumerWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context, ref) {
    final newDocumentState = ref.watch(documentFormProvider);
    return IconButton(
      tooltip: 'Generar Documento',
      onPressed: newDocumentState.isPosting
          ? null
          : () {
              ref.read(documentFormProvider.notifier).onFormSubmit().then(
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
      icon: newDocumentState.isPosting
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
    final newDocumentState = ref.watch(documentFormProvider);
    // final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final remuneracion =
        "\$${StringUtils.formatToNumber(newDocumentState.remuneracion.value)}";
    final size = MediaQuery.sizeOf(context);
    final altura = size.height;
    final ancho = size.width;
    final factorAltura = ancho > 600 ? 0.2 : 0.3;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            .read(documentFormProvider.notifier)
                            .onTribunalChanged,
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
                            ? newDocumentState
                                .fechaInicioRelacionLaboral.errorMessage
                            : null,
                        fecha:
                            newDocumentState.fechaInicioRelacionLaboral.value,
                      ),
                      DateTimeEntryCustom(
                        title: 'Fecha Termino relación laboral',
                        onFechaChanged: ref
                            .read(documentFormProvider.notifier)
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
                            .read(documentFormProvider.notifier)
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
                            .read(documentFormProvider.notifier)
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
                            .read(documentFormProvider.notifier)
                            .onHorasSemanalesChanged,
                      ),
                      CustomNumericTextField(
                        labelText: 'REMUNERACIÓN $remuneracion',
                        isNumeric: true,
                        allowDecimals: true,
                        initialValue: newDocumentState.remuneracion.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.remuneracion.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentFormProvider.notifier)
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
                      onFechaChanged: ref
                          .read(documentFormProvider.notifier)
                          .onFechaAccidenteLaboralChanged,
                      errorMessage: newDocumentState.isFormPosted
                          ? newDocumentState.fechaAccidenteLaboral.errorMessage
                          : null,
                      fecha: newDocumentState.fechaAccidenteLaboral.value,
                    ),
                    SelectTimeEntryCustom(
                      title: 'Hora del accidente',
                      onHoraChanged: ref
                          .read(documentFormProvider.notifier)
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
                        .read(documentFormProvider.notifier)
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
                        .read(documentFormProvider.notifier)
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
    final newDocumentState = ref.watch(documentFormProvider);
    // final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final montoADemandar =
        "\$${StringUtils.formatToNumber(newDocumentState.montoADemandar.value)}";
    final porcentajeIncapacidad =
        "${newDocumentState.porcentajeIncapacidad.value}%";
    final altura = MediaQuery.sizeOf(context).height;
    // final ancho = MediaQuery.sizeOf(context).width;
    // final factorAltura = ancho > 600 ? 0.15 : 0.2;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        labelText:
                            'Porcentaje de incapacidad $porcentajeIncapacidad',
                        isNumeric: true,
                        initialValue:
                            newDocumentState.porcentajeIncapacidad.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .porcentajeIncapacidad.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentFormProvider.notifier)
                            .onPorcentajeIncapacidadChanged,
                      ),
                      CustomNumericTextField(
                        labelText: 'Monto a demandar $montoADemandar',
                        width: 250,
                        isNumeric: true,
                        allowDecimals: true,
                        initialValue: newDocumentState.montoADemandar.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState.montoADemandar.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentFormProvider.notifier)
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
                        .read(documentFormProvider.notifier)
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
                        .read(documentFormProvider.notifier)
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
                        .read(documentFormProvider.notifier)
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
                        .read(documentFormProvider.notifier)
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
    final newDocumentState = ref.watch(documentFormProvider);
    // final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final montoRemuneracionSegunEmpleador =
        "\$${StringUtils.formatToNumber(newDocumentState.montoRemuneracionSegunEmpleador.value)}";
    final montoRemuneracionArt172 =
        "\$${StringUtils.formatToNumber(newDocumentState.montoRemuneracionArt172.value)}";

    // final altura = MediaQuery.sizeOf(context).height;
    // final ancho = MediaQuery.sizeOf(context).width;
    // final factorAltura = ancho > 600 ? 0.15 : 0.2;
    return ListView(
      physics: ScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        labelText:
                            'Monto remuneración empleador $montoRemuneracionSegunEmpleador',
                        hintText: 'Monto de remuneración según empleador',
                        isNumeric: true,
                        allowDecimals: true,
                        initialValue: newDocumentState
                            .montoRemuneracionSegunEmpleador.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .montoRemuneracionSegunEmpleador.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentFormProvider.notifier)
                            .onMontoRemuneracionSegunEmpleadorChanged,
                      ),
                      CustomNumericTextField(
                        labelText:
                            'Monto remuneración art. 172 $montoRemuneracionArt172',
                        hintText: 'Monto de remuneración según el artículo 172',
                        width: 400,
                        isNumeric: true,
                        allowDecimals: true,
                        initialValue:
                            newDocumentState.montoRemuneracionArt172.value,
                        errorMessage: newDocumentState.isFormPosted
                            ? newDocumentState
                                .montoRemuneracionArt172.errorMessage
                            : null,
                        onChanged: ref
                            .read(documentFormProvider.notifier)
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
                                  .read(documentFormProvider.notifier)
                                  .onDocumentoAdicionalChanged,
                            ),
                            IconButton(
                              tooltip: 'Eliminar item',
                              icon: const Icon(Icons.delete_forever_rounded),
                              onPressed: () {
                                ref
                                    .read(documentFormProvider.notifier)
                                    .onRemoveDocumentosAdicionalesAIngresar(
                                        index);
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    IconButton(
                      tooltip: 'Agregar item',
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        ref
                            .read(documentFormProvider.notifier)
                            .onAddDocumentosAdicionalesAIngresar();
                      },
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
