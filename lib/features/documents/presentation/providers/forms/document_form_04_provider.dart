import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../config/config.dart';
import '../../../domain/domain.dart';
import '../documents_provider.dart';
import 'estado_civil.dart';
import 'inputs/inputs.dart';

part 'document_form_04_provider.g.dart';

@Riverpod()
class DocumentForm04 extends _$DocumentForm04 {
  @override
  DocumentForm04State build() {
    return DocumentForm04State();
  }

  ///* index
  void onSelectedIndexChanged(int value) {
    state = state.copyWith(
      selectedIndex: value,
    );
  }

///* DEMANDANTE
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

///* ABOGADO 1
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

  //* ABOGADO 2
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
  void onFechaInicioRelacionLaboralValidate() {
    final fechaInicioRelacionLaboralValidated = state.fechaInicioRelacionLaboral.validate();
    state = state.copyWith( fechaInicioRelacionLaboral: fechaInicioRelacionLaboralValidated);
  }

  void onFechaTerminoRelacionLaboralChanged(DateTime value) {
    final fechaTerminoRelacionLaboralChanged = state.fechaTerminoRelacionLaboral
    .copyWith(value: value, fechaInicio: state.fechaInicioRelacionLaboral.value)
    .onChanged(value);
    state = state.copyWith(fechaTerminoRelacionLaboral: fechaTerminoRelacionLaboralChanged);
  }
  void onFechaTerminoRelacionLaboralValidate() {
    final fechaTerminoRelacionLaboralValidated = state.fechaTerminoRelacionLaboral.validate();
    state = state.copyWith( fechaTerminoRelacionLaboral: fechaTerminoRelacionLaboralValidated);
  }

  void onFechaAutodespidoChanged(DateTime value) {
    final fechaAutodespidoChanged = state.fechaAutodespido.onChanged(value);
    state = state.copyWith( fechaAutodespido: fechaAutodespidoChanged);
  }
  void onFechaAutodespidoValidate() {
    final fechaAutodespidoValidated = state.fechaAutodespido.validate();
    state = state.copyWith( fechaAutodespido: fechaAutodespidoValidated);
  }

  void onFechaReclamoDtChanged(DateTime value) {
    final fechaReclamoDtChanged = state.fechaReclamoDt.onChanged(value);
    state = state.copyWith( fechaReclamoDt: fechaReclamoDtChanged);
  }
  void onFechaReclamoDtValidate() {
    final fechaReclamoDtValidated = state.fechaReclamoDt.validate();
    state = state.copyWith( fechaReclamoDt: fechaReclamoDtValidated);
  }

  void onFechaComparendoDtChanged(DateTime value) {
    final fechaComparendoDtChanged = state.fechaComparendoDt.onChanged(value);
    state = state.copyWith( fechaComparendoDt: fechaComparendoDtChanged);
  }
  void onFechaComparendoDtValidate() {
    final fechaComparendoDtValidated = state.fechaComparendoDt.validate();
    state = state.copyWith( fechaComparendoDt: fechaComparendoDtValidated);
  }

  void onCargoDemandanteChanged(String value) {
    final cargoDemandanteChanged = state.cargoDemandante.onChanged(value);
    state = state.copyWith(cargoDemandante: cargoDemandanteChanged);
  }
  void onCargoDemandanteValidate() {
    final cargoDemandanteValidated = state.cargoDemandante.validate();
    state = state.copyWith(cargoDemandante: cargoDemandanteValidated);
  }

  void onComunaDemandadoSolidarioChanged(String value) {
    final comunaDemandadoSolidarioChanged = state.comunaDemandadoSolidario.onChanged(value);
    state = state.copyWith(comunaDemandadoSolidario: comunaDemandadoSolidarioChanged);
  }
  void onComunaDemandadoSolidarioValidate() {
    final comunaDemandadoSolidarioValidated = state.comunaDemandadoSolidario.validate();
    state = state.copyWith(comunaDemandadoSolidario: comunaDemandadoSolidarioValidated);
  }

  void onTipoContratoChanged(String value) {
    final tipoContratoChanged = state.tipoContrato.onChanged(value);
    state = state.copyWith(tipoContrato: tipoContratoChanged);
  }
  void onTipoContratoValidate() {
    final tipoContratoValidated = state.tipoContrato.validate();
    state = state.copyWith(tipoContrato: tipoContratoValidated);
  }

  void onHorasSemanalesChanged(String value) {
    final horasSemanalesChanged = state.horasSemanales.onChanged(value);
    state = state.copyWith(horasSemanales: horasSemanalesChanged);
  }
  void onHorasSemanalesValidate() {
    final horasSemanalesValidated = state.horasSemanales.validate();
    state = state.copyWith(horasSemanales: horasSemanalesValidated);
  }

  void onRemuneracionChanged(String value) {
    final remuneracionChanged = state.remuneracion.onChanged(value);
    state = state.copyWith(remuneracion: remuneracionChanged);
  }
  void onRemuneracionValidate() {
    final remuneracionValidated = state.remuneracion.validate();
    state = state.copyWith(remuneracion: remuneracionValidated);
  }
  void onRemuneracionPor50Changed(String value) {
    final remuneracionPor50Changed = state.remuneracionPor50.onChanged(value);
    state = state.copyWith(remuneracionPor50: remuneracionPor50Changed);
  }
  void onRemuneracionPor50Validate() {
    final remuneracionPor50Validated = state.remuneracionPor50.validate();
    state = state.copyWith(remuneracionPor50: remuneracionPor50Validated);
  }

  void onHorarioJornadaTrabajoChanged(String value) {
    final horarioJornadaTrabajoChanged = state.horarioJornadaTrabajo.onChanged(value);
    state = state.copyWith(horarioJornadaTrabajo: horarioJornadaTrabajoChanged);
  }
  void onHorarioJornadaTrabajoValidate() {
    final horarioJornadaTrabajoValidated = state.horarioJornadaTrabajo.validate();
    state = state.copyWith(horarioJornadaTrabajo: horarioJornadaTrabajoValidated);
  }

  void onLaboresTrabajadorChanged(String value) {
    final laboresTrabajadorChanged = state.laboresTrabajador.onChanged(value);
    state = state.copyWith(laboresTrabajador: laboresTrabajadorChanged);
  }
  void onLaboresTrabajadorValidate() {
    final laboresTrabajadorValidated = state.laboresTrabajador.validate();
    state = state.copyWith(laboresTrabajador: laboresTrabajadorValidated);
  }
  void onServiciosPrestadosChanged(String value) {
    final serviciosPrestadosChanged = state.serviciosPrestados.onChanged(value);
    state = state.copyWith(serviciosPrestados: serviciosPrestadosChanged);
  }
  void onServiciosPrestadosValidate() {
    final serviciosPrestadosValidated = state.serviciosPrestados.validate();
    state = state.copyWith(serviciosPrestados: serviciosPrestadosValidated);
  }

  void onTipoAFPChanged(String value) {
    final tipoAFPChanged = state.tipoAFP.onChanged(value);
    state = state.copyWith(tipoAFP: tipoAFPChanged);
  }
  void onTipoAFPValidate() {
    final tipoAFPValidated = state.tipoAFP.validate();
    state = state.copyWith(tipoAFP: tipoAFPValidated);
  }

  void onRegionDemandanteChanged(String value) {
    final regionDemandanteChanged = state.regionDemandante.onChanged(value);
    state = state.copyWith(regionDemandante: regionDemandanteChanged);
  }
  void onRegionDemandanteValidate() {
    final regionDemandanteValidated = state.regionDemandante.validate();
    state = state.copyWith(regionDemandante: regionDemandanteValidated);
  }

  void onComunaDemandanteChanged(String value) {
    final comunaDemandanteChanged = state.comunaDemandante.onChanged(value);
    state = state.copyWith(comunaDemandante: comunaDemandanteChanged);
  }
  void onComunaDemandanteValidate() {
    final comunaDemandanteValidated = state.comunaDemandante.validate();
    state = state.copyWith(comunaDemandante: comunaDemandanteValidated);
  }

  void onCalleDireccionDemandanteChanged(String value) {
    final calleDireccionDemandanteChanged = state.calleDireccionDemandante.onChanged(value);
    state = state.copyWith(calleDireccionDemandante: calleDireccionDemandanteChanged);
  }
  void onCalleDireccionDemandanteValidate() {
    final calleDireccionDemandanteValidated = state.calleDireccionDemandante.validate();
    state = state.copyWith(calleDireccionDemandante: calleDireccionDemandanteValidated);
  }

  void onCausalTerminoChanged(String value) {
    final causalTerminoChanged = state.causalTermino.onChanged(value);
    state = state.copyWith(causalTermino: causalTerminoChanged);
  }
  void onCausalTerminoValidate() {
    final causalTerminoValidated = state.causalTermino.validate();
    state = state.copyWith(causalTermino: causalTerminoValidated);
  }

  void onPeriodoImposicionesChanged(String value) {
    final periodoImposicionesChanged = state.periodoImposiciones.onChanged(value);
    state = state.copyWith(periodoImposiciones: periodoImposicionesChanged);
  }
  void onPeriodoImposicionesValidate() {
    final periodoImposicionesValidated = state.periodoImposiciones.validate();
    state = state.copyWith(periodoImposiciones: periodoImposicionesValidated);
  }

  //* Daños y perjuicios
  
  void onFeriadoLegalDiasChanged(String value) {
    final feriadoLegalDiasChanged = state.feriadoLegalDias.onChanged(value);
    state = state.copyWith(feriadoLegalDias: feriadoLegalDiasChanged);
  }
  void onFeriadoLegalDiasValidate() {
    final feriadoLegalDiasValidated = state.feriadoLegalDias.validate();
    state = state.copyWith(feriadoLegalDias: feriadoLegalDiasValidated);
  }

  void onMontoFeriadoLegalChanged(String value) {
    final montoFeriadoLegalChanged = state.montoFeriadoLegal.onChanged(value);
    state = state.copyWith(montoFeriadoLegal: montoFeriadoLegalChanged);
  }
  void onMontoFeriadoLegalValidate() {
    final montoFeriadoLegalValidated = state.montoFeriadoLegal.validate();
    state = state.copyWith(montoFeriadoLegal: montoFeriadoLegalValidated);
  }


  // Compensaciones

  void onMontoDanioMoralChanged(String value) {
    final montoDanioMoralChanged = state.montoDanioMoral.onChanged(value);
    state = state.copyWith(montoDanioMoral: montoDanioMoralChanged);
  }
  void onMontoDanioMoralValidate() {
    final montoDanioMoralValidated = state.montoDanioMoral.validate();
    state = state.copyWith(montoDanioMoral: montoDanioMoralValidated);
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
        final errorPageIndex = _getErrorPageIndex();
        // aquí sería else if para las demás condiciones
        if (errorPageIndex != -1) {
          // quiere decir que encontró la página
          // debería encontrar la página con el error
          // en caso de no encontrala seguramente una entrada
          // faltó agregar en la verificación de la página
          state = state.copyWith(selectedIndex: errorPageIndex);
        }

        return null;
        
      }

      state = state.copyWith(isPosting: true);
      //
      final fechaInicioRelacionLaboral = AppDateUtils.getCustomFormattedDate(state.fechaInicioRelacionLaboral.value!);
      final fechaTerminoRelacionLaboral = AppDateUtils.getCustomFormattedDate(state.fechaTerminoRelacionLaboral.value!);

      final fechaAutodespido = AppDateUtils.getCustomFormattedDate(state.fechaAutodespido.value!);
      final fechaReclamoDt = AppDateUtils.getCustomFormattedDate(state.fechaReclamoDt.value!);
      final fechaComparendoDt = AppDateUtils.getCustomFormattedDate(state.fechaComparendoDt.value!);

      final nameTemplate = 'DDA_recon Rla Lab Autodespido nulidad SIN solidaria - template_04.docx';
      final data = {
        //*Demandante
        'NOMBRE_DEMANDANTE': state.demandanteFullName.value,
        'RUT_DEMANDANTE': state.demandanteRut.value,
        'NACIONALIDAD': state.demandanteNacionalidad.value,
        'DIRECCION_DEMANDANTE': state.demandanteDireccion.value,
        'REGION_DEMANDANTE': state.regionDemandante.value,
        'COMUNA_DEMANDANTE': state.comunaDemandante.value,
        'CALLE_DIRECCION_DEMANDANTE': state.calleDireccionDemandante.value,
        'DON_CORTESIA_DEMANDANTE': state.demandanteGender.donCortesia(),
        'DEMANDANTE_A_O': state.demandanteGender.colocaAO(),
        'LA_ACTORA_EL_ACTOR': state.demandanteGender.actorAO(),
        //* Abogado 1
        'NOMBRE_ABOGADO_1': state.abogado1FullName.value,
        'RUT_ABOGADO_1': state.abogado1Rut.value,
        'CORREO_ABOGADO_1': state.abogado1Email.value,
        //* Abogado 2
        'NOMBRE_ABOGADO_2': state.abogado2FullName.value,
        'RUT_ABOGADO_2': state.abogado2Rut.value,
        'CORREO_ABOGADO_2': state.abogado2Email.value,
        //* Demandado principal
        'NOMBRE_DEMANDADO_PRINCIPAL': state.demandadoPrincipalFullName.value,
        'RUT_DEMANDADO_PRINCIPAL': state.demandadoPrincipalRut.value,
        //* Demandado solidario
        'DEMANDADO_SOLIDARIO': state.demandadoSolidarioFullName.value,
        'RUT_DEMANDADO_SOLIDARIO': state.demandadoSolidarioRut.value,
        'COMUNA_DEMANDADO_SOLIDARIO': state.comunaDemandadoSolidario.value,
        //* Representante Legal principal
        'REPRESENTANTE_LEGAL_DEMANDADO_PRINCIPAL': state.representanteLegalPrincipalFullName.value,
        'RUT_REPRESENTANTE_LEGAL_DEMANDADO_PRINCIPAL': state.representanteLegalPrincipalRut.value,
        'DIRECCION_DEMANDADO_PRINCIPAL': state.representanteLegalPrincipalDomicilio.value,
        'DON_CORTESIA_REPRESENTANTE_LEGAL_DEMANDADO_PRINCIPAL': state.representanteLegalPrincipalGender.donCortesia(),
        // 'DON_DONIA_REPRESENTANTE_LEGAL_DEMANDADO_PRINCIPAL': state.representanteLegalPrincipalGender.donCortesia(),
        //* Representante Legal solidario
        'REPRESENTANTE_LEGAL_DEMANDADO_SOLIDARIO': state.representanteLegalSolidarioFullName.value,
        'RUT_REPRESENTANTE_LEGAL_DEMANDADO_SOLIDARIO': state.representanteLegalSolidarioRut.value,
        'DIRECCION_DEMANDADO_SOLIDARIO': state.representanteLegalSolidarioDomicilio.value,
        
        //* Detalles adicionales del caso
        'NOMBRE_TRIBUNAL': state.tribunal.value,
        'FECHA_INICIO_RELACION_LABORAL': fechaInicioRelacionLaboral,
        'FECHA_TERMINO_RELACION_LABORAL': fechaTerminoRelacionLaboral,
        'FECHA_DE_AUTODESPIDO': fechaAutodespido,
        'FECHA_DE_RECLAMO_DT': fechaReclamoDt,
        'FECHA_DE_COMPARENDO_DT': fechaComparendoDt,
        'CARGO_DEMANDANTE': state.cargoDemandante.value,
        
        'TIPO_DE_CONTRATO': state.tipoContrato.value,
        // 'HORAS_SEMANALES': state.horasSemanales.value,//no lo estoy usando en ésta plantilla
        'HORARIO_JORNADA_DE_TRABAJO': state.horarioJornadaTrabajo.value,
        'TIPO_DE_AFP_TRABAJADOR': state.tipoAFP.value,
        'CAUSAL_DE_TERMINO': state.causalTermino.value,
        'PERIODO_IMPAGO_IMPOSICIONES': state.periodoImposiciones.value,
        'FERIADO_LEGAL_DIAS': state.feriadoLegalDias.value,
        

        'LABORES_DESARROLLADAS_POR_EL_TRABAJADOR': state.laboresTrabajador.value,
        'SERVICIOS_PRESTADOS_POR_LA_PRINCIPAL_A_LA_SOLIDARIA': state.serviciosPrestados.value,

        //* Compensaciones
        'MONTO_DAÑO_MORAL': StringUtils.formatToNumber( state.montoDanioMoral.value),
        'REMUNERACION': StringUtils.formatToNumber(state.remuneracion.value),
        'REMUNERACION_POR_50%': StringUtils.formatToNumber(state.remuneracionPor50.value),
        'MONTO_POR_FERIADO_LEGAL': StringUtils.formatToNumber(state.montoFeriadoLegal.value),
        'DOCUMENTOS': state.documentosAdicionalesAIngresar,
      };

      final documentRequest = {
        'name_template': nameTemplate,
        'data': data,
      };
      
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

  int _getErrorPageIndex() {
    if (!state.isValidInfoPage) return 0;
    if (!state.isValidDetailsPage) return 1;
    if (!state.isValidCompensacionesPage) return 2;
    return -1;
  }

  void resetError() {
    state = state.copyWith(errorMessage: '');
  }

  Future<void> validateInputs() async {
   _validateInfoPage();
   _isValidDetailsPage();
   _isValidCompensacionesPage();
  }

  void _validateInfoPage(){
     // Demandante
    onDemandanteFullNameValidate();
    onDemandanteRutValidate();
    onDemandanteNacionalidadValidate();
    onDemandanteDireccionValidate();
    onRegionDemandanteValidate();
    onComunaDemandanteValidate();
    onCalleDireccionDemandanteValidate();
    // Abogado 1
    onAbogado1FullNameValidate();
    onAbogado1RutValidate();
    onAbogado1EmailValidate();
    // Abogado 2
    onAbogado2FullNameValidate();
    onAbogado2RutValidate();
    onAbogado2EmailValidate();
    // DEMANDADO PRINCIPAL
    onDemandadoPrincipalFullNameValidate();
    onDemandadoPrincipalRutValidate();
    // DEMANDADO SOLIDARIO
    onDemandadoSolidarioFullNameValidate();
    onDemandadoSolidarioRutValidate();
    //* Representante Legal principal
    onRepresentanteLegalPrincipalFullNameValidate();
    onRepresentanteLegalPrincipalRutValidate();
    onRepresentanteLegalPrincipalDomicilioValidate();
    //* Representante Legal solidario
    onRepresentanteLegalSolidarioFullNameValidate();
    onRepresentanteLegalSolidarioRutValidate();
    onRepresentanteLegalSolidarioDomicilioValidate();
  }
  void _isValidDetailsPage(){
    onTribunalValidate();
    onFechaInicioRelacionLaboralValidate();
    onFechaTerminoRelacionLaboralValidate();
    onFechaAutodespidoValidate();
    onFechaReclamoDtValidate();
    onFechaComparendoDtValidate();
    onCargoDemandanteValidate();
    onComunaDemandadoSolidarioValidate();
    onTipoContratoValidate();
    onHorarioJornadaTrabajoValidate();
    onTipoAFPValidate();
    onCausalTerminoValidate();
    onPeriodoImposicionesValidate();
    onFeriadoLegalDiasValidate();

    onLaboresTrabajadorValidate();
    onServiciosPrestadosValidate();
  }

  void _isValidCompensacionesPage(){
    onMontoDanioMoralValidate();
    onRemuneracionValidate();
    onRemuneracionPor50Validate();
    onMontoFeriadoLegalValidate();

  }
}

class DocumentForm04State {
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
  final SimpleString regionDemandante;
  final SimpleString comunaDemandante;
  final SimpleString calleDireccionDemandante;
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
  final SimpleString comunaDemandadoSolidario;
  // Representante Legal Demandado principal
  final Gender representanteLegalPrincipalGender;
  final SimpleString representanteLegalPrincipalFullName;
  final SimpleString representanteLegalPrincipalRut;
  final SimpleString representanteLegalPrincipalDomicilio;
  // Representante Legal Demandado solidario
  final SimpleString representanteLegalSolidarioFullName;
  final SimpleString representanteLegalSolidarioRut;
  final SimpleString representanteLegalSolidarioDomicilio;
  // Detalles adicionales del caso
  final SimpleString tribunal;
  final FechaInput fechaInicioRelacionLaboral;
  final FechaTerminoInput fechaTerminoRelacionLaboral;
  final FechaInput fechaAutodespido;
  final FechaInput fechaReclamoDt;
  final FechaInput fechaComparendoDt;
  final SimpleString cargoDemandante;
  
  final SimpleString serviciosPrestados;

  final SimpleString tipoContrato;
  final SimpleString horarioJornadaTrabajo;
  final SimpleString laboresTrabajador;
  final SimpleString tipoAFP;
  final SimpleString causalTermino;
  
  final SimpleString periodoImposiciones;
  final PositiveIntegerInput horasSemanales;
  final PositiveNumInput remuneracion;
  final PositiveNumInput remuneracionPor50;
  final PositiveNumInput montoFeriadoLegal;
  // Detalles del Accidente

  // final HoraInput horaAccidente;
  // final SimpleString relatoAccidenteExtenso;
  // final SimpleString relatoHechosPosteriores;
  // Daños y perjuicios
  final PositiveIntegerInput feriadoLegalDias;
  // final PositiveNumInput montoADemandar;
  final PositiveNumInput montoDanioMoral;
  // final SimpleString relatoDaniosEsteticos;
  // final SimpleString danioActor;
  // final SimpleString danioTrabajador;
  // final SimpleString medidasNecesariasEmpresaDemandada;
  // Compensaciones
  // final PositiveNumInput montoRemuneracionSegunEmpleador;
  // final PositiveNumInput montoRemuneracionArt172;
  // Lista de documentos adicionales
  final List<String> documentosAdicionalesAIngresar;

  DocumentForm04State({
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
    this.regionDemandante = const SimpleString(value: ''),
    this.comunaDemandante = const SimpleString(value: ''),
    this.calleDireccionDemandante = const SimpleString(value: ''),
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
    this.comunaDemandadoSolidario = const SimpleString(value: ''),
    // Representante Legal principal
    this.representanteLegalPrincipalGender = Gender.hombre,
    this.representanteLegalPrincipalFullName = const SimpleString(value: ''),
    this.representanteLegalPrincipalRut = const SimpleString(value: ''),
    this.representanteLegalPrincipalDomicilio = const SimpleString(value: ''),
    // Representante Legal solidario
    this.representanteLegalSolidarioFullName = const SimpleString(value: ''),
    this.representanteLegalSolidarioRut = const SimpleString(value: ''),
    this.representanteLegalSolidarioDomicilio = const SimpleString(value: ''),
    // Detalles adicionales del caso
    this.tribunal = const SimpleString(value: ''),
    this.fechaInicioRelacionLaboral = const FechaInput(value: null),
    this.fechaTerminoRelacionLaboral = const FechaTerminoInput(value: null, fechaInicio: null),
    this.fechaAutodespido = const FechaInput(value: null),
    this.fechaReclamoDt = const FechaInput(value: null),
    this.fechaComparendoDt = const FechaInput(value: null),
    this.cargoDemandante = const SimpleString(value: ''),
    this.tipoContrato = const SimpleString(value: ''),
    this.laboresTrabajador = const SimpleString(value: ''),
    this.serviciosPrestados = const SimpleString(value: ''),
    this.tipoAFP = const SimpleString(value: ''),
    this.causalTermino = const SimpleString(value: ''),
    this.periodoImposiciones = const SimpleString(value: ''),
    

    this.horasSemanales = const PositiveIntegerInput(value: ''),

    this.feriadoLegalDias = const PositiveIntegerInput(value: ''),
    this.remuneracion = const PositiveNumInput(value: ''),
    this.remuneracionPor50 = const PositiveNumInput(value: ''),
    
    this.horarioJornadaTrabajo = const SimpleString(value: ''),
    // Detalles del Accidente
    // this.horaAccidente = const HoraInput(value: null),
    // this.relatoAccidenteExtenso = const SimpleString(value: ''),
    // this.relatoHechosPosteriores = const SimpleString(value: ''),
    // Daños y perjuicios
    // this.porcentajeIncapacidad = const PositiveIntegerInput(value: ''),
    // this.montoADemandar = const PositiveNumInput(value: ''),
    this.montoDanioMoral = const PositiveNumInput(value: ''),
    this.montoFeriadoLegal = const PositiveNumInput(value: ''),
    // this.relatoDaniosEsteticos = const SimpleString(value: ''),
    // this.danioActor = const SimpleString(value: ''),
    // this.danioTrabajador = const SimpleString(value: ''),
    // this.medidasNecesariasEmpresaDemandada = const SimpleString(value: ''),
    // Compensaciones
    // this.montoRemuneracionSegunEmpleador = const PositiveNumInput(value: ''),
    // this.montoRemuneracionArt172 = const PositiveNumInput(value: ''),
    // Lista de documentos adicionales
    this.documentosAdicionalesAIngresar = const [],
  });

  // si alguna entrada tiene error, entonces no es válido el formulario
  bool get isValidForm => ![
        isValidInfoPage,
        isValidDetailsPage,
        isValidCompensacionesPage,
      ].any((input) => !input);

  bool get isValidInfoPage => ![
        // Demandante
        demandanteFullName.hasError,
        demandanteRut.hasError,
        demandanteNacionalidad.hasError,
        demandanteDireccion.hasError,
        regionDemandante.hasError,
        comunaDemandante.hasError,
        calleDireccionDemandante.hasError,
        // Abogado 1
        abogado1FullName.hasError,
        abogado1Rut.hasError,
        abogado1Email.hasError,
        // Abogado 2
        abogado2FullName.hasError,
        abogado2Rut.hasError,
        abogado2Email.hasError,
        // Demandado Principal
        demandadoPrincipalFullName.hasError,
        demandadoPrincipalRut.hasError,
        // Demandado Solidario
        demandadoSolidarioFullName.hasError,
        demandadoSolidarioRut.hasError,
        comunaDemandadoSolidario.hasError,
        // Representante legal principal
        representanteLegalPrincipalFullName.hasError,
        representanteLegalPrincipalRut.hasError,
        representanteLegalPrincipalDomicilio.hasError,
        // Representante legal solidario
        representanteLegalSolidarioFullName.hasError,
        representanteLegalSolidarioRut.hasError,
        representanteLegalSolidarioDomicilio.hasError,
      ].any((input) => input);

      bool get isValidDetailsPage => ![
        tribunal.hasError,
        fechaInicioRelacionLaboral.hasError,
        fechaTerminoRelacionLaboral.hasError,
        fechaAutodespido.hasError,
        fechaReclamoDt.hasError,
        fechaComparendoDt.hasError,
        cargoDemandante.hasError,
        tipoContrato.hasError,
        horarioJornadaTrabajo.hasError,
        laboresTrabajador.hasError,
        serviciosPrestados.hasError,
        tipoAFP.hasError,
        causalTermino.hasError,
        periodoImposiciones.hasError,
        feriadoLegalDias.hasError,
        
        laboresTrabajador.hasError,
        serviciosPrestados.hasError,

      ].any((input) => input);

      bool get isValidCompensacionesPage => ![
        montoDanioMoral.hasError,
        remuneracion.hasError,
        remuneracionPor50.hasError,
        montoFeriadoLegal.hasError,
      ].any((input) => input);

  DocumentForm04State copyWith({
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
    SimpleString? regionDemandante,
    SimpleString? comunaDemandante,
    SimpleString? calleDireccionDemandante,
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
    SimpleString? comunaDemandadoSolidario,
    // Representante Legal principal
    Gender? representanteLegalPrincipalGender,
    SimpleString? representanteLegalPrincipalFullName,
    SimpleString? representanteLegalPrincipalRut,
    SimpleString? representanteLegalPrincipalDomicilio,
    // Representante Legal solidario
    SimpleString? representanteLegalSolidarioFullName,
    SimpleString? representanteLegalSolidarioRut,
    SimpleString? representanteLegalSolidarioDomicilio,
    // Detalles adicionales del caso
    SimpleString? tribunal,
    FechaInput? fechaInicioRelacionLaboral,
    FechaTerminoInput? fechaTerminoRelacionLaboral,
    FechaInput? fechaAutodespido,
    FechaInput? fechaReclamoDt,
    FechaInput? fechaComparendoDt,
    SimpleString? cargoDemandante,
    
    SimpleString? tipoContrato,
    SimpleString? laboresTrabajador,
    PositiveIntegerInput? horasSemanales,
    PositiveIntegerInput? feriadoLegalDias,
    PositiveNumInput? remuneracion,
    PositiveNumInput? montoFeriadoLegal,
    PositiveNumInput? remuneracionPor50,
    SimpleString? horarioJornadaTrabajo,
    SimpleString? serviciosPrestados,
    SimpleString? tipoAFP,
    SimpleString? causalTermino,
    SimpleString? periodoImposiciones,
    
    // Detalles del Accidente
    // FechaAccidenteInput? fechaAccidenteLaboral,
    // HoraInput? horaAccidente,
    // SimpleString? relatoAccidenteExtenso,
    // SimpleString? relatoHechosPosteriores,
    // Daños y perjuicios
    // PositiveIntegerInput? porcentajeIncapacidad,
    // PositiveNumInput? montoADemandar,
    PositiveNumInput? montoDanioMoral,
    // SimpleString? relatoDaniosEsteticos,
    // SimpleString? danioActor,
    // SimpleString? danioTrabajador,
    // SimpleString? medidasNecesariasEmpresaDemandada,
    // Compensaciones
    // PositiveNumInput? montoRemuneracionSegunEmpleador,
    // PositiveNumInput? montoRemuneracionArt172,
    // Lista de documentos adicionales
    List<String>? documentosAdicionalesAIngresar,
  }) =>
      DocumentForm04State(
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
        demandanteNacionalidad: demandanteNacionalidad ?? this.demandanteNacionalidad,
        regionDemandante: regionDemandante ?? this.regionDemandante,
        comunaDemandante: comunaDemandante ?? this.comunaDemandante,
        calleDireccionDemandante: calleDireccionDemandante ?? this.calleDireccionDemandante,
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
        comunaDemandadoSolidario: comunaDemandadoSolidario ?? this.comunaDemandadoSolidario,
        // Representante Legal principal
        representanteLegalPrincipalGender: representanteLegalPrincipalGender ?? this.representanteLegalPrincipalGender,
        representanteLegalPrincipalFullName: representanteLegalPrincipalFullName ?? this.representanteLegalPrincipalFullName,
        representanteLegalPrincipalRut: representanteLegalPrincipalRut ?? this.representanteLegalPrincipalRut,
        representanteLegalPrincipalDomicilio: representanteLegalPrincipalDomicilio ?? this.representanteLegalPrincipalDomicilio,
        // Representante Legal solidario
        representanteLegalSolidarioFullName: representanteLegalSolidarioFullName ?? this.representanteLegalSolidarioFullName,
        representanteLegalSolidarioRut: representanteLegalSolidarioRut ?? this.representanteLegalSolidarioRut,
        representanteLegalSolidarioDomicilio: representanteLegalSolidarioDomicilio ?? this.representanteLegalSolidarioDomicilio,
        
        // Detalles adicionales del caso
        tribunal: tribunal ?? this.tribunal,
        fechaInicioRelacionLaboral: fechaInicioRelacionLaboral ?? this.fechaInicioRelacionLaboral,
        fechaTerminoRelacionLaboral: fechaTerminoRelacionLaboral ?? this.fechaTerminoRelacionLaboral,
        fechaAutodespido: fechaAutodespido ?? this.fechaAutodespido,
        fechaReclamoDt: fechaReclamoDt ?? this.fechaReclamoDt,
        fechaComparendoDt: fechaComparendoDt ?? this.fechaComparendoDt,
        cargoDemandante: cargoDemandante ?? this.cargoDemandante,
        
        montoFeriadoLegal: montoFeriadoLegal ?? this.montoFeriadoLegal,
        serviciosPrestados: serviciosPrestados ?? this.serviciosPrestados,
        tipoContrato: tipoContrato ?? this.tipoContrato,
        laboresTrabajador: laboresTrabajador ?? this.laboresTrabajador,
        horasSemanales: horasSemanales ?? this.horasSemanales,
        remuneracion: remuneracion ?? this.remuneracion,
        remuneracionPor50: remuneracionPor50 ?? this.remuneracionPor50,
        tipoAFP: tipoAFP ?? this.tipoAFP,
        causalTermino: causalTermino ?? this.causalTermino,
        periodoImposiciones: periodoImposiciones ?? this.periodoImposiciones,
        // Detalles del Accidente
        horarioJornadaTrabajo: horarioJornadaTrabajo ?? this.horarioJornadaTrabajo,
        feriadoLegalDias: feriadoLegalDias ?? this.feriadoLegalDias,
        
        
        // Daños y perjuicios
        // montoADemandar: montoADemandar ?? this.montoADemandar,
        montoDanioMoral: montoDanioMoral ?? this.montoDanioMoral,
        // Compensaciones
        // montoRemuneracionSegunEmpleador: montoRemuneracionSegunEmpleador ?? this.montoRemuneracionSegunEmpleador,
        // montoRemuneracionArt172: montoRemuneracionArt172 ?? this.montoRemuneracionArt172,
        // Lista de documentos adicionales
        documentosAdicionalesAIngresar: documentosAdicionalesAIngresar ?? this.documentosAdicionalesAIngresar,
      );
}
