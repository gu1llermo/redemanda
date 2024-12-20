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
    final demandanteFullName = DemandanteFullName.dirty(value);
    final newState = state.copyWith(demandanteFullName: demandanteFullName);
    _touchEveryThing(newState);
  }

  void onDemandanteRutChanged(String value) {
    final demandanteRut = DemandanteRut.dirty(value);
    final newState = state.copyWith(demandanteRut: demandanteRut);
    _touchEveryThing(newState);
  }

  void onDemandanteNacionalidadChanged(String value) {
    final demandanteNacionalidad = DemandanteNacionalidad.dirty(value);
    final newState = state.copyWith(
      demandanteNacionalidad: demandanteNacionalidad,
    );
    _touchEveryThing(newState);
  }

//* Abogado 1
  void onAbogado1FullNameChanged(String value) {
    final abogado1FullName = Abogado1FullName.dirty(value);
    final newState = state.copyWith(abogado1FullName: abogado1FullName);
    _touchEveryThing(newState);
  }

  void onAbogado1RutChanged(String value) {
    final abogado1Rut = Abogado1Rut.dirty(value);
    final newState = state.copyWith(abogado1Rut: abogado1Rut);
    _touchEveryThing(newState);
  }

  void onAbogado1EmailChanged(String value) {
    final abogado1Email = Abogado1Email.dirty(value);
    final newState = state.copyWith(abogado1Email: abogado1Email);
    _touchEveryThing(newState);
  }

  //* Abogado 2
  void onAbogado2FullNameChanged(String value) {
    final abogado2FullName = Abogado2FullName.dirty(value);
    final newState = state.copyWith(abogado2FullName: abogado2FullName);
    _touchEveryThing(newState);
  }

  void onAbogado2RutChanged(String value) {
    final abogado2Rut = Abogado2Rut.dirty(value);
    final newState = state.copyWith(abogado2Rut: abogado2Rut);
    _touchEveryThing(newState);
  }

  void onAbogado2EmailChanged(String value) {
    final abogado2Email = Abogado2Email.dirty(value);
    final newState = state.copyWith(abogado2Email: abogado2Email);
    _touchEveryThing(newState);
  }

  //* Demandado
  void onDemandadoFullNameChanged(String value) {
    final demandadoFullName = DemandadoFullName.dirty(value);
    final newState = state.copyWith(demandadoFullName: demandadoFullName);
    _touchEveryThing(newState);
  }

  void onDemandadoRutChanged(String value) {
    final demandadoRut = DemandadoRut.dirty(value);
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
    final representanteLegalFullName = RepresentanteLegalFullName.dirty(value);
    final newState =
        state.copyWith(representanteLegalFullName: representanteLegalFullName);
    _touchEveryThing(newState);
  }

  void onRepresentanteLegalRutChanged(String value) {
    final representanteLegalRut = RepresentanteLegalRut.dirty(value);
    final newState =
        state.copyWith(representanteLegalRut: representanteLegalRut);
    _touchEveryThing(newState);
  }

  void onRepresentanteLegalDomicilioChanged(String value) {
    final representanteLegalDomicilio =
        RepresentanteLegalDomicilio.dirty(value);
    final newState = state.copyWith(
      representanteLegalDomicilio: representanteLegalDomicilio,
    );
    _touchEveryThing(newState);
  }

  //* Detalles adicionales del caso
  void onTribunalChanged(String value) {
    final tribunal = Tribunal.dirty(value);
    final newState = state.copyWith(tribunal: tribunal);
    _touchEveryThing(newState);
  }

  void onFechaInicioRelacionLaboralChanged(DateTime value) {
    final fechaInicioRelacionLaboral = FechaInicioRelacionLaboral.dirty(value);
    final newState = state.copyWith(
      fechaInicioRelacionLaboral: fechaInicioRelacionLaboral,
    );
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
      DemandanteFullName.dirty(newState.demandanteFullName.value),
      DemandanteRut.dirty(newState.demandanteRut.value),
      DemandanteNacionalidad.dirty(newState.demandanteNacionalidad.value),
      // Abogado 1
      Abogado1FullName.dirty(newState.abogado1FullName.value),
      Abogado1Rut.dirty(newState.abogado1Rut.value),
      Abogado1Email.dirty(newState.abogado1Email.value),
      // Abogado 2
      Abogado2FullName.dirty(newState.abogado2FullName.value),
      Abogado2Rut.dirty(newState.abogado2Rut.value),
      Abogado2Email.dirty(newState.abogado2Email.value),
      // Demandado
      DemandadoFullName.dirty(newState.demandadoFullName.value),
      DemandadoRut.dirty(newState.demandadoRut.value),
      // Representante Legal
      RepresentanteLegalFullName.dirty(
          newState.representanteLegalFullName.value),
      RepresentanteLegalRut.dirty(newState.representanteLegalRut.value),
      RepresentanteLegalDomicilio.dirty(
          newState.representanteLegalDomicilio.value),
    ]);
  }

  bool _isValidDetailsPage(DocumentFormState newState) {
    return Formz.validate([
      // Detalles adicionales del caso
      Tribunal.dirty(newState.tribunal.value),
      FechaInicioRelacionLaboral.dirty(
          newState.fechaInicioRelacionLaboral.value),
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
  final DemandanteFullName demandanteFullName;
  final DemandanteRut demandanteRut;
  final DemandanteNacionalidad demandanteNacionalidad;
  // Abogado 1
  final Abogado1FullName abogado1FullName;
  final Abogado1Rut abogado1Rut;
  final Abogado1Email abogado1Email;
  // Abogado 2
  final Abogado2FullName abogado2FullName;
  final Abogado2Rut abogado2Rut;
  final Abogado2Email abogado2Email;
  // Demandado
  final DemandadoFullName demandadoFullName;
  final DemandadoRut demandadoRut;
  // Representante Legal
  final Gender representanteLegalGender;
  final RepresentanteLegalFullName representanteLegalFullName;
  final RepresentanteLegalRut representanteLegalRut;
  final RepresentanteLegalDomicilio representanteLegalDomicilio;
  // Detalles adicionales del caso
  final Tribunal tribunal;
  final FechaInicioRelacionLaboral fechaInicioRelacionLaboral;

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
    this.demandanteFullName = const DemandanteFullName.dirty(''),
    this.demandanteRut = const DemandanteRut.dirty(''),
    this.demandanteNacionalidad = const DemandanteNacionalidad.dirty(''),
    // Abogado 1
    this.abogado1FullName = const Abogado1FullName.dirty(''),
    this.abogado1Rut = const Abogado1Rut.dirty(''),
    this.abogado1Email = const Abogado1Email.dirty(''),
    // Abogado 2
    this.abogado2FullName = const Abogado2FullName.dirty(''),
    this.abogado2Rut = const Abogado2Rut.dirty(''),
    this.abogado2Email = const Abogado2Email.dirty(''),
    // Demandando
    this.demandadoFullName = const DemandadoFullName.dirty(''),
    this.demandadoRut = const DemandadoRut.dirty(''),
    // Representante Legal
    this.representanteLegalGender = Gender.hombre,
    this.representanteLegalFullName =
        const RepresentanteLegalFullName.dirty(''),
    this.representanteLegalRut = const RepresentanteLegalRut.dirty(''),
    this.representanteLegalDomicilio =
        const RepresentanteLegalDomicilio.dirty(''),
    // Detalles adicionales del caso
    this.tribunal = const Tribunal.dirty(''),
    this.fechaInicioRelacionLaboral =
        const FechaInicioRelacionLaboral.dirty(null),
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
    DemandanteFullName? demandanteFullName,
    DemandanteRut? demandanteRut,
    DemandanteNacionalidad? demandanteNacionalidad,
    // Abogado 1
    Abogado1FullName? abogado1FullName,
    Abogado1Rut? abogado1Rut,
    Abogado1Email? abogado1Email,
    // Abogado 2
    Abogado2FullName? abogado2FullName,
    Abogado2Rut? abogado2Rut,
    Abogado2Email? abogado2Email,
    // Demandado
    DemandadoFullName? demandadoFullName,
    DemandadoRut? demandadoRut,
    // Representante Legal
    Gender? representanteLegalGender,
    RepresentanteLegalFullName? representanteLegalFullName,
    RepresentanteLegalRut? representanteLegalRut,
    RepresentanteLegalDomicilio? representanteLegalDomicilio,
    // Detalles adicionales del caso
    Tribunal? tribunal,
    FechaInicioRelacionLaboral? fechaInicioRelacionLaboral,
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
