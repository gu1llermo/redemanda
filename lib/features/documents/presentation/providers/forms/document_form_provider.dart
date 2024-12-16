import 'package:formz/formz.dart';
import 'package:redemanda/features/shared/shared.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_form_provider.g.dart';

@Riverpod()
class DocumentForm extends _$DocumentForm {
  @override
  DocumentFormState build() {
    return DocumentFormState();
  }

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

  Future<void> onFormSubmit() async {
    final newState = state.copyWith(isFormPosted: true);
    _touchEveryThing(newState);
    if (!state.isFormValid) return;
    // deshabilitar el botón de posteo
    state = state.copyWith(isPosting: true);
    // Utilizar el repositorio
    try {
      // simulando un petición al server
      await Future.delayed(Duration(seconds: 2));
    } finally {
      state = state.copyWith(isPosting: false);
    }
  }

  void _touchEveryThing(DocumentFormState newState) {
    state = newState.copyWith(
        isFormValid: Formz.validate([
      DemandanteFullName.dirty(newState.demandanteFullName.value),
      DemandanteRut.dirty(newState.demandanteRut.value),
      DemandanteNacionalidad.dirty(newState.demandanteNacionalidad.value),
    ]));
  }
}

class DocumentFormState {
  final bool isFormValid;
  final bool isFormPosted;
  final bool isPosting;
  final Gender demandanteGender;
  final EstadoCivil demandanteEstadoCivil;
  final DemandanteFullName demandanteFullName;
  final DemandanteRut demandanteRut;
  final DemandanteNacionalidad demandanteNacionalidad;

  DocumentFormState({
    this.isFormValid = false,
    this.isFormPosted = false,
    this.isPosting = false,
    this.demandanteGender = Gender.hombre,
    this.demandanteEstadoCivil = EstadoCivil.casado,
    this.demandanteFullName = const DemandanteFullName.dirty(''),
    this.demandanteRut = const DemandanteRut.dirty(''),
    this.demandanteNacionalidad = const DemandanteNacionalidad.dirty(''),
  });

  DocumentFormState copyWith({
    bool? isFormValid,
    bool? isFormPosted,
    bool? isPosting,
    Gender? demandanteGender,
    EstadoCivil? demandanteEstadoCivil,
    DemandanteFullName? demandanteFullName,
    DemandanteRut? demandanteRut,
    DemandanteNacionalidad? demandanteNacionalidad,
  }) =>
      DocumentFormState(
        isFormValid: isFormValid ?? this.isFormValid,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isPosting: isPosting ?? this.isPosting,
        demandanteGender: demandanteGender ?? this.demandanteGender,
        demandanteEstadoCivil:
            demandanteEstadoCivil ?? this.demandanteEstadoCivil,
        demandanteFullName: demandanteFullName ?? this.demandanteFullName,
        demandanteRut: demandanteRut ?? this.demandanteRut,
        demandanteNacionalidad:
            demandanteNacionalidad ?? this.demandanteNacionalidad,
      );
}

enum Gender { hombre, mujer }

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
