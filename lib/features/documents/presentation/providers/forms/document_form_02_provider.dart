import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../config/config.dart';
import '../../../domain/domain.dart';
import '../providers.dart';
import 'estado_civil.dart';
import 'inputs/inputs.dart';

part 'document_form_02_provider.g.dart';

@Riverpod(dependencies: [DocumentsPagination])
class DocumentForm02 extends _$DocumentForm02 {
  @override
  DocumentForm02State build() {
    return DocumentForm02State();
  }

  ///* index
  void onSelectedIndexChanged(int value) {
    state = state.copyWith(
      selectedIndex: value,
    );
  }

///* Demandante
  void onDemandanteGenderChanged(Gender value) {
    state = state.copyWith(
      demandanteGender: value,
    );
  }

  void onDemandanteFullNameChanged(String value) {
    final demandanteFullNameChanged = state.demandanteFullName.onChanged(value);
    state = state.copyWith(demandanteFullName: demandanteFullNameChanged);
  }

  void onDemandanteFullNameValidate() {
    final demandanteFullNameValidated = state.demandanteFullName.validate();
    state = state.copyWith(demandanteFullName: demandanteFullNameValidated);
  }

  void onDemandanteRutChanged(String value) {
    final demandanteRutChanged = state.demandanteRut.onChanged(value);
    state = state.copyWith(demandanteRut: demandanteRutChanged);
  }

  void onDemandanteRutValidate() {
    final demandanteRutValidated = state.demandanteRut.validate();
    state = state.copyWith(demandanteRut: demandanteRutValidated);
  }

  void onDemandanteNacionalidadChanged(String value) {
    final demandanteNacionalidadChanged = state.demandanteNacionalidad.onChanged(value);
    state = state.copyWith(demandanteNacionalidad: demandanteNacionalidadChanged);
  }

  void onDemandanteNacionalidadValidate() {
    final demandanteNacionalidadValidated = state.demandanteNacionalidad.validate();
    state = state.copyWith(demandanteNacionalidad: demandanteNacionalidadValidated);
  }

  void onDemandanteDireccionChanged(String value) {
    final demandanteDireccionChanged = state.demandanteDireccion.onChanged(value);
    state = state.copyWith(demandanteDireccion: demandanteDireccionChanged);
  }

  void onDemandanteDireccionValidate() {
    final demandanteDireccionValidated = state.demandanteDireccion.validate();
    state = state.copyWith(demandanteDireccion: demandanteDireccionValidated);
  }

///* Abogado 1
  void onAbogado1FullNameChanged(String value) {
    final abogado1FullNameChanged = state.abogado1FullName.onChanged(value);
    state = state.copyWith(abogado1FullName: abogado1FullNameChanged);
  }

  void onAbogado1FullNameValidate() {
    final abogado1FullNameValidated = state.abogado1FullName.validate();
    state = state.copyWith(abogado1FullName: abogado1FullNameValidated);
  }

  void onAbogado1RutChanged(String value) {
    final abogado1RutChanged = state.abogado1Rut.onChanged(value);
    state = state.copyWith(abogado1Rut: abogado1RutChanged);
  }

  void onAbogado1RutValidate() {
    final abogado1RutValidated = state.abogado1Rut.validate();
    state = state.copyWith(abogado1Rut: abogado1RutValidated);
  }

   void onAbogado1EmailChanged(String value) {
    final abogado1EmailChanged = state.abogado1Email.onChanged(value);
    state = state.copyWith(abogado1Email: abogado1EmailChanged);
  }

  void onAbogado1EmailValidate() {
    final abogado1EmailValidated = state.abogado1Email.validate();
    state = state.copyWith(abogado1Email: abogado1EmailValidated);
  }

  //* Abogado 2
  void onAbogado2FullNameChanged(String value) {
    final abogado2FullNameChanged = state.abogado2FullName.onChanged(value);
    state = state.copyWith(abogado2FullName: abogado2FullNameChanged);
  }

  void onAbogado2FullNameValidate() {
    final abogado2FullNameValidated = state.abogado2FullName.validate();
    state = state.copyWith(abogado2FullName: abogado2FullNameValidated);
  }

  void onAbogado2RutChanged(String value) {
    final abogado2RutChanged = state.abogado2Rut.onChanged(value);
    state = state.copyWith(abogado2Rut: abogado2RutChanged);
  }

  void onAbogado2RutValidate() {
    final abogado2RutValidated = state.abogado2Rut.validate();
    state = state.copyWith(abogado2Rut: abogado2RutValidated);
  }

   void onAbogado2EmailChanged(String value) {
    final abogado2EmailChanged = state.abogado2Email.onChanged(value);
    state = state.copyWith(abogado2Email: abogado2EmailChanged);
  }

  void onAbogado2EmailValidate() {
    final abogado2EmailValidated = state.abogado2Email.validate();
    state = state.copyWith(abogado2Email: abogado2EmailValidated);
  }

  //* Demandado principal
  void onDemandadoPrincipalFullNameChanged(String value) {
    final demandadoPrincipalFullNameChanged =state.demandadoPrincipalFullName.onChanged(value);
    state = state.copyWith(demandadoPrincipalFullName: demandadoPrincipalFullNameChanged);
  }
  void onDemandadoPrincipalFullNameValidate() {
    final demandadoPrincipalFullNameValidated =state.demandadoPrincipalFullName.validate();
    state = state.copyWith(demandadoPrincipalFullName: demandadoPrincipalFullNameValidated);
  }

  void onDemandadoPrincipalRutChanged(String value) {
    final demandadoPrincipalRutChanged =state.demandadoPrincipalRut.onChanged(value);
    state = state.copyWith(demandadoPrincipalRut: demandadoPrincipalRutChanged);
  }
  void onDemandadoPrincipalRutValidate() {
    final demandadoPrincipalRutValidated =state.demandadoPrincipalRut.validate();
    state = state.copyWith(demandadoPrincipalRut: demandadoPrincipalRutValidated);
  }

  //* Demandado solidario
  void onDemandadoSolidarioFullNameChanged(String value) {
    final demandadoSolidarioFullNameChanged =state.demandadoSolidarioFullName.onChanged(value);
    state = state.copyWith(demandadoSolidarioFullName: demandadoSolidarioFullNameChanged);
  }
  void onDemandadoSolidarioFullNameValidate() {
    final demandadoSolidarioFullNameValidated =state.demandadoSolidarioFullName.validate();
    state = state.copyWith(demandadoSolidarioFullName: demandadoSolidarioFullNameValidated);
  }

  void onDemandadoSolidarioRutChanged(String value) {
    final demandadoSolidarioRutChanged =state.demandadoSolidarioRut.onChanged(value);
    state = state.copyWith(demandadoSolidarioRut: demandadoSolidarioRutChanged);
  }
  void onDemandadoSolidarioRutValidate() {
    final demandadoSolidarioRutValidated =state.demandadoSolidarioRut.validate();
    state = state.copyWith(demandadoSolidarioRut: demandadoSolidarioRutValidated);
  }

  //* Representante Legal principal
  void onRepresentanteLegalPrincipalGenderChanged(Gender value) {
    state = state.copyWith(representanteLegalPrincipalGender: value);
  }

  void onRepresentanteLegalPrincipalFullNameChanged(String value) {
    final representanteLegalPrincipalFullNameChanged = state.representanteLegalPrincipalFullName.onChanged(value);
    state = state.copyWith(representanteLegalPrincipalFullName: representanteLegalPrincipalFullNameChanged);
  }
  void onRepresentanteLegalPrincipalFullNameValidate() {
    final representanteLegalPrincipalFullNameValidated = state.representanteLegalPrincipalFullName.validate();
    state = state.copyWith(representanteLegalPrincipalFullName: representanteLegalPrincipalFullNameValidated);
  }

  void onRepresentanteLegalPrincipalRutChanged(String value) {
    final representanteLegalPrincipalRutChanged = state.representanteLegalPrincipalRut.onChanged(value);
    state = state.copyWith(representanteLegalPrincipalRut: representanteLegalPrincipalRutChanged);
  }
  void onRepresentanteLegalPrincipalRutValidate() {
    final representanteLegalPrincipalRutValidated = state.representanteLegalPrincipalRut.validate();
    state = state.copyWith(representanteLegalPrincipalRut: representanteLegalPrincipalRutValidated);
  }

  void onRepresentanteLegalPrincipalDomicilioChanged(String value) {
    final representanteLegalPrincipalDomicilioChanged = state.representanteLegalPrincipalDomicilio.onChanged(value);
    state = state.copyWith(representanteLegalPrincipalDomicilio: representanteLegalPrincipalDomicilioChanged);
  }
  void onRepresentanteLegalPrincipalDomicilioValidate() {
    final representanteLegalPrincipalDomicilioValidated = state.representanteLegalPrincipalDomicilio.validate();
    state = state.copyWith(representanteLegalPrincipalDomicilio: representanteLegalPrincipalDomicilioValidated);
  }
  //* Representante Legal solidario
  void onRepresentanteLegalSolidarioGenderChanged(Gender value) {
    state = state.copyWith(representanteLegalSolidarioGender: value);
  }

  void onRepresentanteLegalSolidarioFullNameChanged(String value) {
    final representanteLegalSolidarioFullNameChanged = state.representanteLegalSolidarioFullName.onChanged(value);
    state = state.copyWith(representanteLegalSolidarioFullName: representanteLegalSolidarioFullNameChanged);
  }
  void onRepresentanteLegalSolidarioFullNameValidate() {
    final representanteLegalSolidarioFullNameValidated = state.representanteLegalSolidarioFullName.validate();
    state = state.copyWith(representanteLegalSolidarioFullName: representanteLegalSolidarioFullNameValidated);
  }

  void onRepresentanteLegalSolidarioRutChanged(String value) {
    final representanteLegalSolidarioRutChanged = state.representanteLegalSolidarioRut.onChanged(value);
    state = state.copyWith(representanteLegalSolidarioRut: representanteLegalSolidarioRutChanged);
  }
  void onRepresentanteLegalSolidarioRutValidate() {
    final representanteLegalSolidarioRutValidated = state.representanteLegalSolidarioRut.validate();
    state = state.copyWith(representanteLegalSolidarioRut: representanteLegalSolidarioRutValidated);
  }

  void onRepresentanteLegalSolidarioDomicilioChanged(String value) {
    final representanteLegalSolidarioDomicilioChanged = state.representanteLegalSolidarioDomicilio.onChanged(value);
    state = state.copyWith(representanteLegalSolidarioDomicilio: representanteLegalSolidarioDomicilioChanged);
  }
  void onRepresentanteLegalSolidarioDomicilioValidate() {
    final representanteLegalSolidarioDomicilioValidated = state.representanteLegalSolidarioDomicilio.validate();
    state = state.copyWith(representanteLegalSolidarioDomicilio: representanteLegalSolidarioDomicilioValidated);
  }

  //* Detalles adicionales del caso
  void onTribunalChanged(String value) {
    final tribunalChanged = state.tribunal.onChanged(value);
    state = state.copyWith(tribunal: tribunalChanged);
  }

  void onTribunalValidate() {
    final tribunalValidated = state.tribunal.validate();
    state = state.copyWith(tribunal: tribunalValidated);
  }

  void onFechaInicioRelacionLaboralChanged(DateTime value) {
    final fechaInicioRelacionLaboralChanged = state.fechaInicioRelacionLaboral.onChanged(value);
    state = state.copyWith( fechaInicioRelacionLaboral: fechaInicioRelacionLaboralChanged);
    
  }

  void onFechaTerminoRelacionLaboralChanged(DateTime value) {
    final fechaTerminoRelacionLaboralChanged = state.fechaTerminoRelacionLaboral
    .copyWith(value: value, fechaInicio: state.fechaInicioRelacionLaboral.value)
    .onChanged(value);
    state = state.copyWith(fechaTerminoRelacionLaboral: fechaTerminoRelacionLaboralChanged);
  }

  void onCargoTrabajadorChanged(String value) {
    final cargoTrabajador = SimpleStringInput.dirty(value);
    final newState = state.copyWith(cargoTrabajador: cargoTrabajador);
    _touchEveryThing(newState);
  }

  void onTipoContratoChanged(String value) {
    final tipoContrato = SimpleStringInput.dirty(value);
    final newState = state.copyWith(tipoContrato: tipoContrato);
    _touchEveryThing(newState);
  }

  void onHorasSemanalesChanged(String value) {
    final horasSemanales = PositiveIntegerInput.dirty(value);
    final newState = state.copyWith(horasSemanales: horasSemanales);
    _touchEveryThing(newState);
  }

  void onRemuneracionChanged(String value) {
    final remuneracion = PositiveNumInput.dirty(value);
    final newState = state.copyWith(remuneracion: remuneracion);
    _touchEveryThing(newState);
  }

  //* Detalles del Accidente
  void onFechaAccidenteLaboralChanged(DateTime value) {
    final fechaAccidenteLaboral = FechaAccidenteInput.dirty(
      value,
      fechaInicio: state.fechaInicioRelacionLaboral.value,
      fechaTermino: state.fechaTerminoRelacionLaboral.value,
    );
    final newState =
        state.copyWith(fechaAccidenteLaboral: fechaAccidenteLaboral);
    _touchEveryThing(newState);
  }

  void onHoraAccidenteChanged(TimeOfDay value) {
    final horaAccidente = HoraInput.dirty(value);
    final newState = state.copyWith(horaAccidente: horaAccidente);
    _touchEveryThing(newState);
  }

  void onRelatoAccidenteExtensoChanged(String value) {
    final relatoAccidenteExtenso = SimpleStringInput.dirty(value);
    final newState =
        state.copyWith(relatoAccidenteExtenso: relatoAccidenteExtenso);
    _touchEveryThing(newState);
  }

  void onRelatoHechosPosterioresChanged(String value) {
    final relatoHechosPosteriores = SimpleStringInput.dirty(value);
    final newState =
        state.copyWith(relatoHechosPosteriores: relatoHechosPosteriores);
    _touchEveryThing(newState);
  }

  //* Daños y perjuicios
  void onPorcentajeIncapacidadChanged(String value) {
    final porcentajeIncapacidad = PositiveIntegerInput.dirty(value);
    final newState =
        state.copyWith(porcentajeIncapacidad: porcentajeIncapacidad);
    _touchEveryThing(newState);
  }

  void onMontoADemandarChanged(String value) {
    final montoADemandar = PositiveNumInput.dirty(value);
    final newState = state.copyWith(montoADemandar: montoADemandar);
    _touchEveryThing(newState);
  }

  void onRelatoDaniosEsteticosChanged(String value) {
    final relatoDaniosEsteticos = SimpleStringInput.dirty(value);
    final newState =
        state.copyWith(relatoDaniosEsteticos: relatoDaniosEsteticos);
    _touchEveryThing(newState);
  }

  void onDanioActorChanged(String value) {
    final danioActor = SimpleStringInput.dirty(value);
    final newState = state.copyWith(danioActor: danioActor);
    _touchEveryThing(newState);
  }

  void onDanioTrabajadorChanged(String value) {
    final danioTrabajador = SimpleStringInput.dirty(value);
    final newState = state.copyWith(danioTrabajador: danioTrabajador);
    _touchEveryThing(newState);
  }

  void onMedidasNecesariasEmpresaDemandadaChanged(String value) {
    final medidasNecesariasEmpresaDemandada = SimpleStringInput.dirty(value);
    final newState = state.copyWith(
      medidasNecesariasEmpresaDemandada: medidasNecesariasEmpresaDemandada,
    );
    _touchEveryThing(newState);
  }

  // Compensaciones
  void onMontoRemuneracionSegunEmpleadorChanged(String value) {
    final montoRemuneracionSegunEmpleador = PositiveNumInput.dirty(value);
    final newState = state.copyWith(
      montoRemuneracionSegunEmpleador: montoRemuneracionSegunEmpleador,
    );
    _touchEveryThing(newState);
  }

  void onMontoRemuneracionArt172Changed(String value) {
    final montoRemuneracionArt172 = PositiveNumInput.dirty(value);
    final newState = state.copyWith(
      montoRemuneracionArt172: montoRemuneracionArt172,
    );
    _touchEveryThing(newState);
  }

  void onRemoveDocumentosAdicionalesAIngresar(int index) {
    state = state.copyWith(
      documentosAdicionalesAIngresar:
          List.from(state.documentosAdicionalesAIngresar)..removeAt(index),
    );
  }

  void onDocumentoAdicionalChanged(String value, int index) {
    state = state.copyWith(
      documentosAdicionalesAIngresar:
          List.from(state.documentosAdicionalesAIngresar)..[index] = value,
    );
  }

  void onAddDocumentosAdicionalesAIngresar() {
    state = state.copyWith(
      documentosAdicionalesAIngresar: [
        ...state.documentosAdicionalesAIngresar,
        ''
      ],
    );
  }

  //* Botón incrementar página
  void incrementarIndex() {
    final newIndex = state.selectedIndex + 1;
    state = state.copyWith(selectedIndex: newIndex);
  }

  //* Botón decrementar página
  void decrementarIndex() {
    final newIndex = state.selectedIndex - 1;
    state = state.copyWith(selectedIndex: newIndex);
  }

  //* Botón de posteo
  Future<Document?> onFormSubmit() async {
    try {
      state = state.copyWith(isFormPosted: true);
      await validateInputs();
      if (!state.isValidForm) {
        // entonces me gustaría determinar la página que tiene el error
        // 0 - InfoPage
        int index = -1;
        if (!state.isValidInfoPage) {
          index = 0;
        }
        // else if (!_isValidDetailsPage(newState)) {
        //   index = 1;
        // } else if (!_isValidDaniosPage(newState)) {
        //   index = 2;
        // } else if (!_isValidCompensacionesPage(newState)) {
        //   index = 3;
        // }
        // aquí sería else if para las demás condiciones
        if (index != -1) {
          // quiere decir que encontró la página
          state = state.copyWith(selectedIndex: index);
        }

        return null;
        // throw Exception('Por favor, complete todos los campos');
      }

      state = state.copyWith(isPosting: true);
      //
      final fechaInicioRelacionLaboral = AppDateUtils.getCustomFormattedDate(
          state.fechaInicioRelacionLaboral.value!);
      final fechaTerminoRelacionLaboral = AppDateUtils.getCustomFormattedDate(
          state.fechaTerminoRelacionLaboral.value!);
      final nameTemplate = 'template_02.docx';
      final data = {
        //*Demandante
        'nombre_demandante': state.demandanteFullName.value,
        'rut_demandante': state.demandanteRut.value,
        'nacionalidad': state.demandanteNacionalidad.value,
        // 'estado_civil':
        //     state.demandanteEstadoCivil.texto(state.demandanteGender),
        'don_cortesia_demandante': state.demandanteGender.donCortesia(),
        //* Abogado 1
        'nombre_abogado_1': state.abogado1FullName.value,
        'rut_abogado_1': state.abogado1Rut.value,
        'correo_abogado_1': state.abogado1Email.value,
        //* Abogado 2
        'nombre_abogado_2': state.abogado2FullName.value,
        'rut_abogado_2': state.abogado2Rut.value,
        'correo_abogado_2': state.abogado2Email.value,
        //* Demandado
        'nombre_demandado': state.demandadoPrincipalFullName.value,
        'rut_demandado': state.demandadoPrincipalRut.value,
        //* Representante Legal
        'nombre_representante_legal': state.representanteLegalPrincipalFullName.value,
        'rut_representante_legal': state.representanteLegalPrincipalRut.value,
        'domicilio_empresa': state.representanteLegalPrincipalDomicilio.value,
        'don_cortesia_representante_legal':
            state.representanteLegalPrincipalGender.donCortesia(),
        //* Detalles adicionales del caso
        'tribunal': state.tribunal.value,
        'fecha_inicio_relacion_laboral': fechaInicioRelacionLaboral,
        'fecha_termino_relacion_laboral': fechaTerminoRelacionLaboral,
        'cargo_trabajador': state.cargoTrabajador.value,
        'tipo_de_contrato': state.tipoContrato.value,
        'horas_semanales_jornada_laboral': state.horasSemanales.value,
        'remuneracion': StringUtils.formatToNumber(state.remuneracion.value),
        //* Detalles del Accidente
        // 'fecha_accidente_laboral': AppDateUtils.getCustomFormattedDate(
        //   state.fechaAccidenteLaboral.value!,
        // ),
        'hora_accidente':
            AppDateUtils.getFormattedHora(state.horaAccidente.value!),
        'relato_del_accidente_extenso': state.relatoAccidenteExtenso.value,
        'relato_hechos_posteriores_al_accidente_extenso':
            state.relatoHechosPosteriores.value,
        //* Daños y perjuicios
        'porcentaje_incapacidad': state.porcentajeIncapacidad.value,
        'monto_a_demandar':
            StringUtils.formatToNumber(state.montoADemandar.value),
        'relato_danios_esteticos': state.relatoDaniosEsteticos.value,
        'danio_que_tiene_el_actor': state.danioActor.value,
        'danio_del_trabajador': state.danioTrabajador.value,
        'medidas_necesarias_empresa_demandada':
            state.medidasNecesariasEmpresaDemandada.value,
        //* Compensaciones
        'monto_de_remuneracion_segun_empleador': StringUtils.formatToNumber(
            state.montoRemuneracionSegunEmpleador.value),
        'monto_remuneracion_segun_articulo_172': StringUtils.formatToNumber(
          state.montoRemuneracionArt172.value,
        ),
        'lista_documentos_ingresar_demanda':
            state.documentosAdicionalesAIngresar,
      };

      final documentRequest = {
        'name_template': nameTemplate,
        'data': data,
      };
      // simulando un petición al server
      // await Future.delayed(Duration(seconds: 2));
      final newDocument = await ref
          .read(documentsPaginationProvider.notifier)
          .createDocument(documentRequest);
      state = state.copyWith(isPosting: false, errorMessage: '');
      return newDocument;
    } on Exception catch (e) {
      state = state.copyWith(isPosting: false, errorMessage: e.toString());
      return null;
    }
  }

  void resetError() {
    state = state.copyWith(errorMessage: '');
  }

  Future<void> validateInputs() async {
    // Demandante
    onDemandanteFullNameValidate();
    onDemandanteRutValidate();
    onDemandanteDireccionValidate();
    onDemandanteNacionalidadValidate();
    // Abogado 1
    onAbogado1FullNameValidate();
    onAbogado1EmailValidate();
    onAbogado1RutValidate();
    // Abogado 2
    onAbogado2FullNameValidate();
    onAbogado2EmailValidate();
    onAbogado2RutValidate();


  }
}

class DocumentForm02State {
  // errorMessage
  final String errorMessage;
  // index
  final int selectedIndex; // para las diferentes páginas
  // Utiles del formulario
  // final bool isFormValid;
  final bool isFormPosted;
  final bool isPosting;
  /// DEMANDANTE
  final Gender demandanteGender;
  final SimpleString demandanteDireccion;
  final SimpleString demandanteFullName;
  final SimpleString demandanteRut;
  final SimpleString demandanteNacionalidad;
  // ABOGADO 1
  final SimpleString abogado1FullName;
  final SimpleString abogado1Rut;
  final Email abogado1Email;
  // ABOGADO 2
  final SimpleString abogado2FullName;
  final SimpleString abogado2Rut;
  final Email abogado2Email;
  // Demandado principal
  final SimpleString demandadoPrincipalFullName;
  final SimpleString demandadoPrincipalRut;
  // Demandado solidario
  final SimpleString demandadoSolidarioFullName;
  final SimpleString demandadoSolidarioRut;
  // Representante Legal Demandado principal
  final Gender representanteLegalPrincipalGender;
  final SimpleString representanteLegalPrincipalFullName;
  final SimpleString representanteLegalPrincipalRut;
  final SimpleString representanteLegalPrincipalDomicilio;
  // Representante Legal Demandado solidario
  final Gender representanteLegalSolidarioGender;
  final SimpleString representanteLegalSolidarioFullName;
  final SimpleString representanteLegalSolidarioRut;
  final SimpleString representanteLegalSolidarioDomicilio;
  // Detalles adicionales del caso
  final SimpleString tribunal;
  final FechaInput fechaInicioRelacionLaboral;
  final FechaTerminoInput fechaTerminoRelacionLaboral;
  final SimpleString cargoTrabajador;
  final SimpleString tipoContrato;
  final PositiveIntegerInput horasSemanales;
  final PositiveNumInput remuneracion;
  // Detalles del Accidente

  final HoraInput horaAccidente;
  final SimpleString relatoAccidenteExtenso;
  final SimpleString relatoHechosPosteriores;
  // Daños y perjuicios
  final PositiveIntegerInput porcentajeIncapacidad;
  final PositiveNumInput montoADemandar;
  final SimpleString relatoDaniosEsteticos;
  final SimpleString danioActor;
  final SimpleString danioTrabajador;
  final SimpleString medidasNecesariasEmpresaDemandada;
  // Compensaciones
  final PositiveNumInput montoRemuneracionSegunEmpleador;
  final PositiveNumInput montoRemuneracionArt172;
  // Lista de documentos adicionales
  final List<String> documentosAdicionalesAIngresar;

  DocumentForm02State({
    this.errorMessage = '',
    this.selectedIndex = 0,
    // utiles del formulario
    // this.isFormValid = false,
    this.isFormPosted = false,
    this.isPosting = false,
    // Demandante
    this.demandanteGender = Gender.hombre,
    this.demandanteDireccion = const SimpleString(value: ''),
    this.demandanteFullName = const SimpleString(value: ''),
    this.demandanteRut = const SimpleString(value: ''),
    this.demandanteNacionalidad = const SimpleString(value: ''),
    // Abogado 1
    this.abogado1FullName = const SimpleString(value: ''),
    this.abogado1Rut = const SimpleString(value: ''),
    this.abogado1Email = const Email(value: ''),
    // Abogado 2
    this.abogado2FullName = const SimpleString(value: ''),
    this.abogado2Rut = const SimpleString(value: ''),
    this.abogado2Email = const Email(value: ''),
    // Demandando principal
    this.demandadoPrincipalFullName = const SimpleString(value: ''),
    this.demandadoPrincipalRut = const SimpleString(value: ''),
    // Demandando solidario
    this.demandadoSolidarioFullName = const SimpleString(value: ''),
    this.demandadoSolidarioRut = const SimpleString(value: ''),
    // Representante Legal principal
    this.representanteLegalPrincipalGender = Gender.hombre,
    this.representanteLegalPrincipalFullName = const SimpleString(value: ''),
    this.representanteLegalPrincipalRut = const SimpleString(value: ''),
    this.representanteLegalPrincipalDomicilio = const SimpleString(value: ''),
    // Representante Legal solidario
    this.representanteLegalSolidarioGender = Gender.hombre,
    this.representanteLegalSolidarioFullName = const SimpleString(value: ''),
    this.representanteLegalSolidarioRut = const SimpleString(value: ''),
    this.representanteLegalSolidarioDomicilio = const SimpleString(value: ''),
    // Detalles adicionales del caso
    this.tribunal = const SimpleString(value: ''),
    this.fechaInicioRelacionLaboral = const FechaInput(value: null),
    this.fechaTerminoRelacionLaboral =
        const FechaTerminoInput(value: null, fechaInicio: null),
    this.cargoTrabajador = const SimpleString(value: ''),
    this.tipoContrato = const SimpleString(value: ''),
    this.horasSemanales = const PositiveIntegerInput(value: ''),
    this.remuneracion = const PositiveNumInput(value: ''),
    // Detalles del Accidente
    this.horaAccidente = const HoraInput(value: null),
    this.relatoAccidenteExtenso = const SimpleString(value: ''),
    this.relatoHechosPosteriores = const SimpleString(value: ''),
    // Daños y perjuicios
    this.porcentajeIncapacidad = const PositiveIntegerInput(value: ''),
    this.montoADemandar = const PositiveNumInput(value: ''),
    this.relatoDaniosEsteticos = const SimpleString(value: ''),
    this.danioActor = const SimpleString(value: ''),
    this.danioTrabajador = const SimpleString(value: ''),
    this.medidasNecesariasEmpresaDemandada = const SimpleString(value: ''),
    // Compensaciones
    this.montoRemuneracionSegunEmpleador = const PositiveNumInput(value: ''),
    this.montoRemuneracionArt172 = const PositiveNumInput(value: ''),
    // Lista de documentos adicionales
    this.documentosAdicionalesAIngresar = const [],
  });

  // si alguna entrada tiene error, entonces no es válido el formulario
  bool get isValidForm => ![
        isValidInfoPage,
      ].any((input) => !input);

  bool get isValidInfoPage => ![
        demandadoPrincipalFullName.hasError,
      ].any((input) => input);

  DocumentForm02State copyWith({
    String? errorMessage,
    // index
    int? selectedIndex,
    // utiles del formulario
    bool? isFormPosted,
    bool? isPosting,
    // Demandante
    Gender? demandanteGender,
    SimpleString? demandanteFullName,
    SimpleString? demandanteRut,
    SimpleString? demandanteNacionalidad,
    SimpleString? demandanteDireccion,
    // Abogado 1
    SimpleString? abogado1FullName,
    SimpleString? abogado1Rut,
    Email? abogado1Email,
    // Abogado 2
    SimpleString? abogado2FullName,
    SimpleString? abogado2Rut,
    Email? abogado2Email,
    // Demandado principal
    SimpleString? demandadoPrincipalFullName,
    SimpleString? demandadoPrincipalRut,
    // Demandado solidario
    SimpleString? demandadoSolidarioFullName,
    SimpleString? demandadoSolidarioRut,
    // Representante Legal principal
    Gender? representanteLegalPrincipalGender,
    SimpleString? representanteLegalPrincipalFullName,
    SimpleString? representanteLegalPrincipalRut,
    SimpleString? representanteLegalPrincipalDomicilio,
    // Representante Legal solidario
    Gender? representanteLegalSolidarioGender,
    SimpleString? representanteLegalSolidarioFullName,
    SimpleString? representanteLegalSolidarioRut,
    SimpleString? representanteLegalSolidarioDomicilio,
    // Detalles adicionales del caso
    SimpleString? tribunal,
    FechaInput? fechaInicioRelacionLaboral,
    FechaTerminoInput? fechaTerminoRelacionLaboral,
    SimpleString? cargoTrabajador,
    SimpleString? tipoContrato,
    PositiveIntegerInput? horasSemanales,
    PositiveNumInput? remuneracion,
    // Detalles del Accidente
    // FechaAccidenteInput? fechaAccidenteLaboral,
    HoraInput? horaAccidente,
    SimpleString? relatoAccidenteExtenso,
    SimpleString? relatoHechosPosteriores,
    // Daños y perjuicios
    PositiveIntegerInput? porcentajeIncapacidad,
    PositiveNumInput? montoADemandar,
    SimpleString? relatoDaniosEsteticos,
    SimpleString? danioActor,
    SimpleString? danioTrabajador,
    SimpleString? medidasNecesariasEmpresaDemandada,
    // Compensaciones
    PositiveNumInput? montoRemuneracionSegunEmpleador,
    PositiveNumInput? montoRemuneracionArt172,
    // Lista de documentos adicionales
    List<String>? documentosAdicionalesAIngresar,
  }) =>
      DocumentForm02State(
        errorMessage: errorMessage ?? this.errorMessage,
        // index
        selectedIndex: selectedIndex ?? this.selectedIndex,
        // pageController: pageController ?? this.pageController,
        // utiles del formulario
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
        // Demandante
        demandanteGender: demandanteGender ?? this.demandanteGender,
       demandanteDireccion: demandanteDireccion ?? this.demandanteDireccion,
        demandanteFullName: demandanteFullName ?? this.demandanteFullName,
        demandanteRut: demandanteRut ?? this.demandanteRut,
        demandanteNacionalidad:
            demandanteNacionalidad ?? this.demandanteNacionalidad,
        // Abogado 1
        abogado1FullName: abogado1FullName ?? this.abogado1FullName,
        abogado1Rut: abogado1Rut ?? this.abogado1Rut,
        abogado1Email: abogado1Email ?? this.abogado1Email,
        // Abogado 2
        abogado2FullName: abogado2FullName ?? this.abogado2FullName,
        abogado2Rut: abogado2Rut ?? this.abogado2Rut,
        abogado2Email: abogado2Email ?? this.abogado2Email,
        // Demandado Principal
        demandadoPrincipalFullName: demandadoPrincipalFullName ?? this.demandadoPrincipalFullName,
        demandadoPrincipalRut: demandadoPrincipalRut ?? this.demandadoPrincipalRut,
        // Demandado Solidario
        demandadoSolidarioFullName: demandadoSolidarioFullName ?? this.demandadoSolidarioFullName,
        demandadoSolidarioRut: demandadoSolidarioRut ?? this.demandadoSolidarioRut,
        // Representante Legal principal
        representanteLegalPrincipalGender:
            representanteLegalPrincipalGender ?? this.representanteLegalPrincipalGender,
        representanteLegalPrincipalFullName:
            representanteLegalPrincipalFullName ?? this.representanteLegalPrincipalFullName,
        representanteLegalPrincipalRut: representanteLegalPrincipalRut ?? this.representanteLegalPrincipalRut,
        representanteLegalPrincipalDomicilio: representanteLegalPrincipalDomicilio ?? this.representanteLegalPrincipalDomicilio,
        // Representante Legal solidario
        representanteLegalSolidarioGender: representanteLegalSolidarioGender ?? this.representanteLegalSolidarioGender,
        representanteLegalSolidarioFullName: representanteLegalSolidarioFullName ?? this.representanteLegalSolidarioFullName,
        representanteLegalSolidarioRut: representanteLegalSolidarioRut ?? this.representanteLegalSolidarioRut,
        representanteLegalSolidarioDomicilio: representanteLegalSolidarioDomicilio ?? this.representanteLegalSolidarioDomicilio,
        // Detalles adicionales del caso
        tribunal: tribunal ?? this.tribunal,
        fechaInicioRelacionLaboral: fechaInicioRelacionLaboral ?? this.fechaInicioRelacionLaboral,
        fechaTerminoRelacionLaboral: fechaTerminoRelacionLaboral ?? this.fechaTerminoRelacionLaboral,
        cargoTrabajador: cargoTrabajador ?? this.cargoTrabajador,
        tipoContrato: tipoContrato ?? this.tipoContrato,
        horasSemanales: horasSemanales ?? this.horasSemanales,
        remuneracion: remuneracion ?? this.remuneracion,
        // Detalles del Accidente
        // fechaAccidenteLaboral:
        //     fechaAccidenteLaboral ?? this.fechaAccidenteLaboral,
        horaAccidente: horaAccidente ?? this.horaAccidente,
        relatoAccidenteExtenso:
            relatoAccidenteExtenso ?? this.relatoAccidenteExtenso,
        relatoHechosPosteriores:
            relatoHechosPosteriores ?? this.relatoHechosPosteriores,
        // Daños y perjuicios
        porcentajeIncapacidad:
            porcentajeIncapacidad ?? this.porcentajeIncapacidad,
        montoADemandar: montoADemandar ?? this.montoADemandar,
        relatoDaniosEsteticos:
            relatoDaniosEsteticos ?? this.relatoDaniosEsteticos,
        danioActor: danioActor ?? this.danioActor,
        danioTrabajador: danioTrabajador ?? this.danioTrabajador,
        medidasNecesariasEmpresaDemandada: medidasNecesariasEmpresaDemandada ??
            this.medidasNecesariasEmpresaDemandada,
        // Compensaciones
        montoRemuneracionSegunEmpleador: montoRemuneracionSegunEmpleador ??
            this.montoRemuneracionSegunEmpleador,
        montoRemuneracionArt172:
            montoRemuneracionArt172 ?? this.montoRemuneracionArt172,
        // Lista de documentos adicionales
        documentosAdicionalesAIngresar: documentosAdicionalesAIngresar ??
            this.documentosAdicionalesAIngresar,
      );
}
