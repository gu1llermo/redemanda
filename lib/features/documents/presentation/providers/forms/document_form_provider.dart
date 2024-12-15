import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'document_form_provider.g.dart';

@Riverpod()
class DocumentForm extends _$DocumentForm {
  @override
  DocumentFormState build() {
    final estadoCivil = EstadoCivil.casado;
    estadoCivil.texto(Gender.hombre);
    return DocumentFormState();
  }
}

class DocumentFormState {
  final Gender demandanteGender;
  final EstadoCivil demandanteEstadoCivil;

  DocumentFormState({
    this.demandanteGender = Gender.hombre,
    this.demandanteEstadoCivil = EstadoCivil.casado,
  });

  DocumentFormState copyWith({
    Gender? demandanteGender,
    EstadoCivil? demandanteEstadoCivil,
  }) =>
      DocumentFormState(
        demandanteGender: demandanteGender ?? this.demandanteGender,
        demandanteEstadoCivil:
            demandanteEstadoCivil ?? this.demandanteEstadoCivil,
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
