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

enum Gender {
  hombre,
  mujer;

  String donCortesia() {
    return this == Gender.hombre ? 'don' : 'doña';
  }
  String colocaAO() {
    return this == Gender.hombre ? 'o' : 'a';
  }
  String actorAO() {
    return this == Gender.hombre ? 'el actor' : 'la actora';
  }
}