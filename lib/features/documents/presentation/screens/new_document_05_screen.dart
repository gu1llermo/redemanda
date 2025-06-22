import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocument05Screen extends ConsumerStatefulWidget {
  const NewDocument05Screen({super.key});
  static const path = 'new-document-05';
  static const title = 'Plantilla nro 5';
  static const description =
      'DDA_recon Rla Lab Autodespido nulidad SIN solidaria sin Daño moral.docx';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument05ScreenState();
}

class _NewDocument05ScreenState extends ConsumerState<NewDocument05Screen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Plantilla nro 5'),
      ),
    );
  }
}
