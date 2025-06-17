import '../../../../../../config/utils/string_utils.dart';
import 'input_form.dart';

class PositiveNumInput extends InputForm<String, PositiveNumInput> {
  const PositiveNumInput({
    required super.value,
    super.hasError,
  });

  @override
  PositiveNumInput copyWith({
    String? value,
    bool? hasError,
  }) =>
      PositiveNumInput(
        value: value ?? this.value,
        hasError: hasError ?? this.hasError,
      );

  @override
  String? get errorMessage {
    final valueTrim = value.trim();
    if (valueTrim.isEmpty) return 'Campo requerido';
    num valueNumber = 0.0;
    try {
      // valueNumber = double.parse(value);
      valueNumber = StringUtils.parseToNum(valueTrim);
    } catch (e) {
      return 'Formato inválido';
    }

    if (valueNumber <= 0.0) return 'Debe ser > 0';

    return null;
  }
}
