import 'package:formz/formz.dart';
import 'package:redemanda/features/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../../config/config.dart';

part 'document_form_provider.g.dart';

@Riverpod()
class DocumentForm extends _$DocumentForm {
  @override
  DocumentFormState build() {
    // ref.onDispose(
    //   () {
    //     state.pageController.dispose();
    //   },
    // );
    return DocumentFormState();
    // return DocumentFormState(pageController: PageController(keepPage: true));
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

  //* Botón de posteo
  Future<void> onFormSubmit() async {
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
      }
      // aquí sería else if para las demás condiciones
      if (index != -1) {
        // quiere decir que encontró la página
        state = state.copyWith(selectedIndex: index);
      }

      return;
    }
    // deshabilitar el botón de posteo
    state = state.copyWith(isPosting: true);
    // Utilizar el repositorio
    final fechaInicioRelacionLaboral = AppDateUtils.getCustomFormattedDate(
        state.fechaInicioRelacionLaboral.value!);
    final fechaTerminoRelacionLaboral = AppDateUtils.getCustomFormattedDate(
        state.fechaTerminoRelacionLaboral.value!);
    // formatear remuneración
    final remuneracion = StringUtils.formatToNumber(state.remuneracion.value);

    final newDocument = {
      //*Demandante
      'nombre_demandante': state.demandanteFullName.value,
      'rut_demandante': state.demandanteRut.value,
      'nacionalidad': state.demandanteNacionalidad.value,
      'estado_civil': state.demandanteEstadoCivil.texto(state.demandanteGender),
      'don_cortesia_demandante': state.demandanteGender.donCortesia(),
      //* Abogado 1
      'nombre_abogado_1': state.abogado1FullName.value,
      'rut_abogado_1': state.abogado1Rut.value,
      'correo_abogado_1': state.abogado1Email,
      //* Abogado 2
      'nombre_abogado_2': state.abogado2FullName.value,
      'rut_abogado_2': state.abogado2Rut.value,
      'correo_abogado_2': state.abogado2Email,
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
      'remuneracion': remuneracion,
      //
    };
    try {
      // simulando un petición al server
      await Future.delayed(Duration(seconds: 2));
      // return true;
    } on Exception catch (e) {
      // return false; // ocurrió un error en la petición al servidor
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

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
    ]);
  }

  void _touchEveryThing(DocumentFormState newState) {
    state = newState.copyWith(
      // aquí utilizar operador && para
      // que se cumplan todas las condiciones
      isFormValid: _isValidInfoPage(newState) && _isValidDetailsPage(newState),
    );
  }
}

class DocumentFormState {
  // index
  final int selectedIndex; // para las diferentes páginas
  // final PageController pageController;
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

  DocumentFormState({
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
  });

  DocumentFormState copyWith({
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
  }) =>
      DocumentFormState(
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
        //
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
