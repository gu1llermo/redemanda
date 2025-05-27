import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocument04Screen extends ConsumerStatefulWidget {
  const NewDocument04Screen({super.key});
  static const path = 'new-document-04';
  static const title = 'Plantilla nro 4';
  static const description =
      'Reconocimiento de relación laboral con nulidad (sin pago de imposiciones), SIN daño moral y una empresa demandada';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument04ScreenState();
}

class _NewDocument04ScreenState extends ConsumerState<NewDocument04Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Plantilla nro 4'),
      ),
    );
  }
}
