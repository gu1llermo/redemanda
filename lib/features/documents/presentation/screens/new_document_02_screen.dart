import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocument02Screen extends ConsumerStatefulWidget {
  const NewDocument02Screen({super.key});
  static const path = 'new-document-02';
  static const title = 'Plantilla nro 2';
  static const description =
      'Reconocimiento de relación laboral con nulidad (sin pago de imposiciones), con daño moral y una empresa demandada';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument02ScreenState();
}

class _NewDocument02ScreenState extends ConsumerState<NewDocument02Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Plantilla nro 2'),
      ),
    );
  }
}
