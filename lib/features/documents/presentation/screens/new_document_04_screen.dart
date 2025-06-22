import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocument04Screen extends ConsumerStatefulWidget {
  const NewDocument04Screen({super.key});
  static const path = 'new-document-04';
  static const title = 'Plantilla nro 4';
  static const description =
      'DDA_recon Rla Lab Autodespido nulidad SIN solidaria.docx';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument04ScreenState();
}

class _NewDocument04ScreenState extends ConsumerState<NewDocument04Screen>
    with SingleTickerProviderStateMixin {
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
