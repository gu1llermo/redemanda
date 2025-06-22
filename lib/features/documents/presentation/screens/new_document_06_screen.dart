import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocument06Screen extends ConsumerStatefulWidget {
  const NewDocument06Screen({super.key});
  static const path = 'new-document-06';
  static const title = 'Plantilla nro 6';
  static const description = 'ESTOY DEJANDO ÉSTE SCREEN PARA LUEGO UTILIZARLO';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument06ScreenState();
}

class _NewDocument06ScreenState extends ConsumerState<NewDocument06Screen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('Plantilla nro 6'),
      ),
    );
  }
}
