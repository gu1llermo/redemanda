import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:redemanda/features/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../config/config.dart';
import '../../../domain/domain.dart';
import '../providers.dart';

part 'document_form_provider.g.dart';

@Riverpod()
class DocumentForm extends _$DocumentForm {
  @override
  DocumentFormState build() {
    return DocumentFormState();
  }

  // index
  void onSelectedIndexChanged(int value) {
    state = state.copyWith(
      selectedIndex: value,
    );
  }

//* Demandante
  void onDemandanteGenderChanged(Gender value) {
    state = state.copyWith(
      demandanteGender: value,
    );
  }

  void onDemandanteEstadoCivilChanged(EstadoCivil value) {
    state = state.copyWith(
      demandanteEstadoCivil: value,
    );
  }

  void onDemandanteFullNameChanged(String value) {
    final demandanteFullName = SimpleStringInput.dirty(value);
    final newState = state.copyWith(demandanteFullName: demandanteFullName);
    _touchEveryThing(newState);
  }

  void onDemandanteRutChanged(String value) {
    final demandanteRut = SimpleStringInput.dirty(value);
    final newState = state.copyWith(demandanteRut: demandanteRut);
    _touchEveryThing(newState);
  }

  void onDemandanteNacionalidadChanged(String value) {
    final demandanteNacionalidad = SimpleStringInput.dirty(value);
    final newState = state.copyWith(
      demandanteNacionalidad: demandanteNacionalidad,
    );
    _touchEveryThing(newState);
  }

//* Abogado 1
  void onAbogado1FullNameChanged(String value) {
    final abogado1FullName = SimpleStringInput.dirty(value);
    final newState = state.copyWith(abogado1FullName: abogado1FullName);
    _touchEveryThing(newState);
  }

  void onAbogado1RutChanged(String value) {
    final abogado1Rut = SimpleStringInput.dirty(value);
    final newState = state.copyWith(abogado1Rut: abogado1Rut);
    _touchEveryThing(newState);
  }

  void onAbogado1EmailChanged(String value) {
    final abogado1Email = Email.dirty(value);
    final newState = state.copyWith(abogado1Email: abogado1Email);
    _touchEveryThing(newState);
  }

  //* Abogado 2
  void onAbogado2FullNameChanged(String value) {
    final abogado2FullName = SimpleStringInput.dirty(value);
    final newState = state.copyWith(abogado2FullName: abogado2FullName);
    _touchEveryThing(newState);
  }

  void onAbogado2RutChanged(String value) {
    final abogado2Rut = SimpleStringInput.dirty(value);
    final newState = state.copyWith(abogado2Rut: abogado2Rut);
    _touchEveryThing(newState);
  }

  void onAbogado2EmailChanged(String value) {
    final abogado2Email = Email.dirty(value);
    final newState = state.copyWith(abogado2Email: abogado2Email);
    _touchEveryThing(newState);
  }

  //* Demandado
  void onDemandadoFullNameChanged(String value) {
    final demandadoFullName = SimpleStringInput.dirty(value);
    final newState = state.copyWith(demandadoFullName: demandadoFullName);
    _touchEveryThing(newState);
  }

  void onDemandadoRutChanged(String value) {
    final demandadoRut = SimpleStringInput.dirty(value);
    final newState = state.copyWith(demandadoRut: demandadoRut);
    _touchEveryThing(newState);
  }

  //* Representante Legal
  void onRepresentanteLegalGenderChanged(Gender value) {
    state = state.copyWith(
      representanteLegalGender: value,
    );
  }

  void onRepresentanteLegalFullNameChanged(String value) {
    final representanteLegalFullName = SimpleStringInput.dirty(value);
    final newState =
        state.copyWith(representanteLegalFullName: representanteLegalFullName);
    _touchEveryThing(newState);
  }

  void onRepresentanteLegalRutChanged(String value) {
    final representanteLegalRut = SimpleStringInput.dirty(value);
    final newState =
        state.copyWith(representanteLegalRut: representanteLegalRut);
    _touchEveryThing(newState);
  }

  void onRepresentanteLegalDomicilioChanged(String value) {
    final representanteLegalDomicilio = SimpleStringInput.dirty(value);
    final newState = state.copyWith(
      representanteLegalDomicilio: representanteLegalDomicilio,
    );
    _touchEveryThing(newState);
  }

  //* Detalles adicionales del caso
  void onTribunalChanged(String value) {
    final tribunal = SimpleStringInput.dirty(value);
    final newState = state.copyWith(tribunal: tribunal);
    _touchEveryThing(newState);
  }

  void onFechaInicioRelacionLaboralChanged(DateTime value) {
    final fechaInicioRelacionLaboral = FechaInput.dirty(value);
    final newState = state.copyWith(
      fechaInicioRelacionLaboral: fechaInicioRelacionLaboral,
    );
    _touchEveryThing(newState);
  }

  void onFechaTerminoRelacionLaboralChanged(DateTime value) {
    final fechaTerminoRelacionLaboral = FechaTerminoInput.dirty(value,
        fechaInicio: state.fechaInicioRelacionLaboral.value);
    final newState = state.copyWith(
      fechaTerminoRelacionLaboral: fechaTerminoRelacionLaboral,
    );
    _touchEveryThing(newState);
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

  //* Botón de posteo
  Future<Document?> onFormSubmit() async {
    final newState = state.copyWith(isFormPosted: true);
    _touchEveryThing(newState);
    if (!state.isFormValid) {
      // entonces me gustaría determinar la página que tiene el error
      // 0 - InfoPage
      int index = -1;
      if (!_isValidInfoPage(state)) {
        index = 0;
      } else if (!_isValidDetailsPage(newState)) {
        index = 1;
      } else if (!_isValidDaniosPage(newState)) {
        index = 2;
      } else if (!_isValidCompensacionesPage(newState)) {
        index = 3;
      }
      // aquí sería else if para las demás condiciones
      if (index != -1) {
        // quiere decir que encontró la página
        state = state.copyWith(selectedIndex: index);
      }

      return null;
    }
    // deshabilitar el botón de posteo
    state = state.copyWith(isPosting: true);
    //
    final fechaInicioRelacionLaboral = AppDateUtils.getCustomFormattedDate(
        state.fechaInicioRelacionLaboral.value!);
    final fechaTerminoRelacionLaboral = AppDateUtils.getCustomFormattedDate(
        state.fechaTerminoRelacionLaboral.value!);
    final nameTemplate = 'template_01.docx';
    final data = {
      //*Demandante
      'nombre_demandante': state.demandanteFullName.value,
      'rut_demandante': state.demandanteRut.value,
      'nacionalidad': state.demandanteNacionalidad.value,
      'estado_civil': state.demandanteEstadoCivil.texto(state.demandanteGender),
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
      'nombre_demandado': state.demandadoFullName.value,
      'rut_demandado': state.demandadoRut.value,
      //* Representante Legal
      'nombre_representante_legal': state.representanteLegalFullName.value,
      'rut_representante_legal': state.representanteLegalRut.value,
      'domicilio_empresa': state.representanteLegalDomicilio.value,
      'don_cortesia_representante_legal':
          state.representanteLegalGender.donCortesia(),
      //* Detalles adicionales del caso
      'tribunal': state.tribunal.value,
      'fecha_inicio_relacion_laboral': fechaInicioRelacionLaboral,
      'fecha_termino_relacion_laboral': fechaTerminoRelacionLaboral,
      'cargo_trabajador': state.cargoTrabajador.value,
      'tipo_contrato': state.tipoContrato.value,
      'horas_semanales': state.horasSemanales.value,
      'remuneracion': StringUtils.formatToNumber(state.remuneracion.value),
      //* Detalles del Accidente
      'fecha_accidente_laboral': AppDateUtils.getCustomFormattedDate(
        state.fechaAccidenteLaboral.value!,
      ),
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
      //* Compensaciones
      'monto_de_remuneracion_segun_empleador': StringUtils.formatToNumber(
          state.montoRemuneracionSegunEmpleador.value),
      'monto_remuneracion_segun_articulo_172': StringUtils.formatToNumber(
        state.montoRemuneracionArt172.value,
      ),
      'lista_documentos_ingresar_demanda': state.documentosAdicionalesAIngresar,
    };
    try {
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

  // bool _isValidInfoPage(DocumentFormState newState) {
  //   return Formz.validate([
  //     ..._getInfoPageFields(newState),
  //   ]);
  // }

  // List<FormzInput<dynamic, dynamic>> _getInfoPageFields(
  //     DocumentFormState newState) {
  //   return [
  //     // Demandante
  //     SimpleStringInput.dirty(newState.demandanteFullName.value),
  //     SimpleStringInput.dirty(newState.demandanteRut.value),
  //     SimpleStringInput.dirty(newState.demandanteNacionalidad.value),
  //     // Abogado 1
  //     SimpleStringInput.dirty(newState.abogado1FullName.value),
  //     SimpleStringInput.dirty(newState.abogado1Rut.value),
  //     Email.dirty(newState.abogado1Email.value),
  //     // Abogado 2
  //     SimpleStringInput.dirty(newState.abogado2FullName.value),
  //     SimpleStringInput.dirty(newState.abogado2Rut.value),
  //     Email.dirty(newState.abogado2Email.value),
  //     // Demandado
  //     SimpleStringInput.dirty(newState.demandadoFullName.value),
  //     SimpleStringInput.dirty(newState.demandadoRut.value),
  //     // Representante Legal
  //     SimpleStringInput.dirty(newState.representanteLegalFullName.value),
  //     SimpleStringInput.dirty(newState.representanteLegalRut.value),
  //     SimpleStringInput.dirty(newState.representanteLegalDomicilio.value),
  //   ];
  // }

  bool _isValidInfoPage(DocumentFormState newState) {
    return Formz.validate([
      // Demandante
      SimpleStringInput.dirty(newState.demandanteFullName.value),
      SimpleStringInput.dirty(newState.demandanteRut.value),
      SimpleStringInput.dirty(newState.demandanteNacionalidad.value),
      // Abogado 1
      SimpleStringInput.dirty(newState.abogado1FullName.value),
      SimpleStringInput.dirty(newState.abogado1Rut.value),
      Email.dirty(newState.abogado1Email.value),
      // Abogado 2
      SimpleStringInput.dirty(newState.abogado2FullName.value),
      SimpleStringInput.dirty(newState.abogado2Rut.value),
      Email.dirty(newState.abogado2Email.value),
      // Demandado
      SimpleStringInput.dirty(newState.demandadoFullName.value),
      SimpleStringInput.dirty(newState.demandadoRut.value),
      // Representante Legal
      SimpleStringInput.dirty(newState.representanteLegalFullName.value),
      SimpleStringInput.dirty(newState.representanteLegalRut.value),
      SimpleStringInput.dirty(newState.representanteLegalDomicilio.value),
    ]);
  }

  bool _isValidDetailsPage(DocumentFormState newState) {
    return Formz.validate([
      // Detalles adicionales del caso
      SimpleStringInput.dirty(newState.tribunal.value),
      FechaInput.dirty(newState.fechaInicioRelacionLaboral.value),
      FechaTerminoInput.dirty(
        newState.fechaTerminoRelacionLaboral.value,
        fechaInicio: newState.fechaInicioRelacionLaboral.value,
      ),
      SimpleStringInput.dirty(newState.cargoTrabajador.value),
      SimpleStringInput.dirty(newState.tipoContrato.value),
      PositiveIntegerInput.dirty(newState.horasSemanales.value),
      PositiveNumInput.dirty(newState.remuneracion.value),
      // Detalles del Accidente
      FechaAccidenteInput.dirty(
        newState.fechaAccidenteLaboral.value,
        fechaInicio: state.fechaInicioRelacionLaboral.value,
        fechaTermino: state.fechaTerminoRelacionLaboral.value,
      ),
      HoraInput.dirty(state.horaAccidente.value),
      SimpleStringInput.dirty(state.relatoAccidenteExtenso.value),
      SimpleStringInput.dirty(state.relatoHechosPosteriores.value),
    ]);
  }

  bool _isValidDaniosPage(DocumentFormState newState) {
    return Formz.validate([
      // Daños y perjuicios
      PositiveIntegerInput.dirty(newState.porcentajeIncapacidad.value),
      PositiveNumInput.dirty(newState.montoADemandar.value),
      SimpleStringInput.dirty(newState.relatoDaniosEsteticos.value),
      SimpleStringInput.dirty(newState.danioActor.value),
      SimpleStringInput.dirty(newState.danioTrabajador.value),
    ]);
  }

  bool _isValidCompensacionesPage(DocumentFormState newState) {
    return Formz.validate([
      // Compensaciones
      PositiveNumInput.dirty(newState.montoRemuneracionSegunEmpleador.value),
      PositiveNumInput.dirty(newState.montoRemuneracionArt172.value),
    ]);
  }
  // bool _isValidDetailsPage(DocumentFormState newState) {
  //   return Formz.validate([
  //     ..._getDetailsPageFields(newState),
  //   ]);
  // }

  // List<FormzInput<dynamic, dynamic>> _getDetailsPageFields(
  //     DocumentFormState newState) {
  //   return [
  //     // Detalles adicionales del caso
  //     SimpleStringInput.dirty(newState.tribunal.value),
  //     FechaInput.dirty(newState.fechaInicioRelacionLaboral.value),
  //     FechaTerminoInput.dirty(
  //       newState.fechaTerminoRelacionLaboral.value,
  //       fechaInicio: newState.fechaInicioRelacionLaboral.value,
  //     ),
  //     SimpleStringInput.dirty(newState.cargoTrabajador.value),
  //     SimpleStringInput.dirty(newState.tipoContrato.value),
  //     PositiveIntegerInput.dirty(newState.horasSemanales.value),
  //     PositiveNumInput.dirty(newState.remuneracion.value),
  //     // Detalles del Accidente
  //     FechaAccidenteInput.dirty(
  //       newState.fechaAccidenteLaboral.value,
  //       fechaInicio: state.fechaInicioRelacionLaboral.value,
  //       fechaTermino: state.fechaTerminoRelacionLaboral.value,
  //     ),
  //     HoraInput.dirty(state.horaAccidente.value),
  //     SimpleStringInput.dirty(state.relatoAccidenteExtenso.value),
  //     SimpleStringInput.dirty(state.relatoHechosPosteriores.value),
  //   ];
  // }

  // bool _isValidAllPages(DocumentFormState newState) {
  //   // tuve que hacerlo así para que se validaran todos los campos
  //   // ya que si uso el operador && apenas la primera condición es falsa
  //   // deja de evaluar las demás
  //   // tampoco funcionó así, genera el mismo comportamiento
  //   return Formz.validate([
  //     ..._getDetailsPageFields(newState),
  //     ..._getInfoPageFields(newState),
  //   ]);
  // }

  void _touchEveryThing(DocumentFormState newState) {
    state = newState.copyWith(
      // aquí utilizar operador && para
      // que se cumplan todas las condiciones
      // isFormValid: _isValidAllPages(newState),
      isFormValid: _isValidInfoPage(newState) &&
          _isValidDetailsPage(newState) &&
          _isValidDaniosPage(newState) &&
          _isValidCompensacionesPage(newState),
    );
  }
}

class DocumentFormState {
  // errorMessage
  final String errorMessage;
  // index
  final int selectedIndex; // para las diferentes páginas
  // Utiles del formulario
  final bool isFormValid;
  final bool isFormPosted;
  final bool isPosting;
  // Demandante
  final Gender demandanteGender;
  final EstadoCivil demandanteEstadoCivil;
  final SimpleStringInput demandanteFullName;
  final SimpleStringInput demandanteRut;
  final SimpleStringInput demandanteNacionalidad;
  // Abogado 1
  final SimpleStringInput abogado1FullName;
  final SimpleStringInput abogado1Rut;
  final Email abogado1Email;
  // Abogado 2
  final SimpleStringInput abogado2FullName;
  final SimpleStringInput abogado2Rut;
  final Email abogado2Email;
  // Demandado
  final SimpleStringInput demandadoFullName;
  final SimpleStringInput demandadoRut;
  // Representante Legal
  final Gender representanteLegalGender;
  final SimpleStringInput representanteLegalFullName;
  final SimpleStringInput representanteLegalRut;
  final SimpleStringInput representanteLegalDomicilio;
  // Detalles adicionales del caso
  final SimpleStringInput tribunal;
  final FechaInput fechaInicioRelacionLaboral;
  final FechaTerminoInput fechaTerminoRelacionLaboral;
  final SimpleStringInput cargoTrabajador;
  final SimpleStringInput tipoContrato;
  final PositiveIntegerInput horasSemanales;
  final PositiveNumInput remuneracion;
  // Detalles del Accidente
  final FechaAccidenteInput fechaAccidenteLaboral;
  final HoraInput horaAccidente;
  final SimpleStringInput relatoAccidenteExtenso;
  final SimpleStringInput relatoHechosPosteriores;
  // Daños y perjuicios
  final PositiveIntegerInput porcentajeIncapacidad;
  final PositiveNumInput montoADemandar;
  final SimpleStringInput relatoDaniosEsteticos;
  final SimpleStringInput danioActor;
  final SimpleStringInput danioTrabajador;
  // Compensaciones
  final PositiveNumInput montoRemuneracionSegunEmpleador;
  final PositiveNumInput montoRemuneracionArt172;
  // Lista de documentos adicionales
  final List<String> documentosAdicionalesAIngresar;

  DocumentFormState({
    this.errorMessage = '',
    // index
    this.selectedIndex = 0,
    // required this.pageController,
    // utiles del formulario
    this.isFormValid = false,
    this.isFormPosted = false,
    this.isPosting = false,
    // index

    // Demandante
    this.demandanteGender = Gender.hombre,
    this.demandanteEstadoCivil = EstadoCivil.casado,
    this.demandanteFullName = const SimpleStringInput.dirty(''),
    this.demandanteRut = const SimpleStringInput.dirty(''),
    this.demandanteNacionalidad = const SimpleStringInput.dirty(''),
    // Abogado 1
    this.abogado1FullName = const SimpleStringInput.dirty(''),
    this.abogado1Rut = const SimpleStringInput.dirty(''),
    this.abogado1Email = const Email.dirty(''),
    // Abogado 2
    this.abogado2FullName = const SimpleStringInput.dirty(''),
    this.abogado2Rut = const SimpleStringInput.dirty(''),
    this.abogado2Email = const Email.dirty(''),
    // Demandando
    this.demandadoFullName = const SimpleStringInput.dirty(''),
    this.demandadoRut = const SimpleStringInput.dirty(''),
    // Representante Legal
    this.representanteLegalGender = Gender.hombre,
    this.representanteLegalFullName = const SimpleStringInput.dirty(''),
    this.representanteLegalRut = const SimpleStringInput.dirty(''),
    this.representanteLegalDomicilio = const SimpleStringInput.dirty(''),
    // Detalles adicionales del caso
    this.tribunal = const SimpleStringInput.dirty(''),
    this.fechaInicioRelacionLaboral = const FechaInput.dirty(null),
    this.fechaTerminoRelacionLaboral = const FechaTerminoInput.dirty(null),
    this.cargoTrabajador = const SimpleStringInput.dirty(''),
    this.tipoContrato = const SimpleStringInput.dirty(''),
    this.horasSemanales = const PositiveIntegerInput.dirty(''),
    this.remuneracion = const PositiveNumInput.dirty(''),
    // Detalles del Accidente
    this.fechaAccidenteLaboral = const FechaAccidenteInput.dirty(null),
    this.horaAccidente = const HoraInput.dirty(null),
    this.relatoAccidenteExtenso = const SimpleStringInput.dirty(''),
    this.relatoHechosPosteriores = const SimpleStringInput.dirty(''),
    // Daños y perjuicios
    this.porcentajeIncapacidad = const PositiveIntegerInput.dirty(''),
    this.montoADemandar = const PositiveNumInput.dirty(''),
    this.relatoDaniosEsteticos = const SimpleStringInput.dirty(''),
    this.danioActor = const SimpleStringInput.dirty(''),
    this.danioTrabajador = const SimpleStringInput.dirty(''),
    // Compensaciones
    this.montoRemuneracionSegunEmpleador = const PositiveNumInput.dirty(''),
    this.montoRemuneracionArt172 = const PositiveNumInput.dirty(''),
    // Lista de documentos adicionales
    this.documentosAdicionalesAIngresar = const [],
  });

  DocumentFormState copyWith({
    String? errorMessage,
    // index
    int? selectedIndex,
    // PageController? pageController,
    // utiles del formulario
    bool? isFormValid,
    bool? isFormPosted,
    bool? isPosting,
    // Demandante
    Gender? demandanteGender,
    EstadoCivil? demandanteEstadoCivil,
    SimpleStringInput? demandanteFullName,
    SimpleStringInput? demandanteRut,
    SimpleStringInput? demandanteNacionalidad,
    // Abogado 1
    SimpleStringInput? abogado1FullName,
    SimpleStringInput? abogado1Rut,
    Email? abogado1Email,
    // Abogado 2
    SimpleStringInput? abogado2FullName,
    SimpleStringInput? abogado2Rut,
    Email? abogado2Email,
    // Demandado
    SimpleStringInput? demandadoFullName,
    SimpleStringInput? demandadoRut,
    // Representante Legal
    Gender? representanteLegalGender,
    SimpleStringInput? representanteLegalFullName,
    SimpleStringInput? representanteLegalRut,
    SimpleStringInput? representanteLegalDomicilio,
    // Detalles adicionales del caso
    SimpleStringInput? tribunal,
    FechaInput? fechaInicioRelacionLaboral,
    FechaTerminoInput? fechaTerminoRelacionLaboral,
    SimpleStringInput? cargoTrabajador,
    SimpleStringInput? tipoContrato,
    PositiveIntegerInput? horasSemanales,
    PositiveNumInput? remuneracion,
    // Detalles del Accidente
    FechaAccidenteInput? fechaAccidenteLaboral,
    HoraInput? horaAccidente,
    SimpleStringInput? relatoAccidenteExtenso,
    SimpleStringInput? relatoHechosPosteriores,
    // Daños y perjuicios
    PositiveIntegerInput? porcentajeIncapacidad,
    PositiveNumInput? montoADemandar,
    SimpleStringInput? relatoDaniosEsteticos,
    SimpleStringInput? danioActor,
    SimpleStringInput? danioTrabajador,
    // Compensaciones
    PositiveNumInput? montoRemuneracionSegunEmpleador,
    PositiveNumInput? montoRemuneracionArt172,
    // Lista de documentos adicionales
    List<String>? documentosAdicionalesAIngresar,
  }) =>
      DocumentFormState(
        errorMessage: errorMessage ?? this.errorMessage,
        // index
        selectedIndex: selectedIndex ?? this.selectedIndex,
        // pageController: pageController ?? this.pageController,
        // utiles del formulario
        isFormValid: isFormValid ?? this.isFormValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
        // Demandante
        demandanteGender: demandanteGender ?? this.demandanteGender,
        demandanteEstadoCivil:
            demandanteEstadoCivil ?? this.demandanteEstadoCivil,
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
        // Demandado
        demandadoFullName: demandadoFullName ?? this.demandadoFullName,
        demandadoRut: demandadoRut ?? this.demandadoRut,
        // Representante Legal
        representanteLegalGender:
            representanteLegalGender ?? this.representanteLegalGender,
        representanteLegalFullName:
            representanteLegalFullName ?? this.representanteLegalFullName,
        representanteLegalRut:
            representanteLegalRut ?? this.representanteLegalRut,
        representanteLegalDomicilio:
            representanteLegalDomicilio ?? this.representanteLegalDomicilio,
        // Detalles adicionales del caso
        tribunal: tribunal ?? this.tribunal,
        fechaInicioRelacionLaboral:
            fechaInicioRelacionLaboral ?? this.fechaInicioRelacionLaboral,
        fechaTerminoRelacionLaboral:
            fechaTerminoRelacionLaboral ?? this.fechaTerminoRelacionLaboral,
        cargoTrabajador: cargoTrabajador ?? this.cargoTrabajador,
        tipoContrato: tipoContrato ?? this.tipoContrato,
        horasSemanales: horasSemanales ?? this.horasSemanales,
        remuneracion: remuneracion ?? this.remuneracion,
        // Detalles del Accidente
        fechaAccidenteLaboral:
            fechaAccidenteLaboral ?? this.fechaAccidenteLaboral,
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

enum Gender {
  hombre,
  mujer;

  String donCortesia() {
    return this == Gender.hombre ? 'don' : 'doña';
  }
}

enum EstadoCivil {
  casado,
  soltero,
  divorciado,
  separado,
  viudo;

  String texto(Gender gender) {
    final subName = name.substring(0, name.length - 1);
    return '$subName${gender == Gender.hombre ? 'o' : 'a'}';
  }
}
