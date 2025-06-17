import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocument02Screen extends ConsumerStatefulWidget {
  const NewDocument02Screen({super.key});
  static const path = 'new-document-02';
  static const title = 'Plantilla nro 2';
  static const description =
      'DDA_recon Rla Lab Autodespido nulidad con solidaria.docx';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NewDocument02ScreenState();
}

class _NewDocument02ScreenState extends ConsumerState<NewDocument02Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    // Sincronizar TabController con el estado
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        // ref
        //     .read(documentForm02Provider.notifier)
        //     .onSelectedIndexChanged(_tabController.index);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
