import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocument03Screen extends ConsumerStatefulWidget {
  const NewDocument03Screen({super.key});
  static const path = 'new-document-03';
  static const title = 'Plantilla nro 3';
  static const description =
      'Reconocimiento de relación laboral con nulidad (sin pago de imposiciones), con daño moral y DOS empresas demandadas solidaridad';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument03ScreenState();
}

class _NewDocument03ScreenState extends ConsumerState<NewDocument03Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Plantilla nro 3'),
      ),
    );
  }
}
