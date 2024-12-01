import 'package:flutter_test/flutter_test.dart';
import 'package:redemanda/config/config.dart';

void main() {
  group(
    'Tests de titleContains',
    () {
      test('Probando con un solo termino y epacio', () {
        expect(
          StringUtils.searchFlexible('Guillermo Isaac Nuñez duran', 'gui '),
          isTrue,
        );
      });
      test('Probando con dos terminos', () {
        expect(
          StringUtils.searchFlexible('Guillermo Isaac Nuñez duran', 'gui nu'),
          isTrue,
        );
      });
      test('Probando cuando no existe coincidencia exacta', () {
        expect(
          StringUtils.searchFlexible('Guillermo Isaac Nuñez duran', 'gui x'),
          isTrue,
        );
      });
      test('Probando en diferente orden', () {
        expect(
          StringUtils.searchFlexible(
              'Informe de ventas mensual', 'ventas informe'),
          isTrue,
        );
      });
    },
  );
}
