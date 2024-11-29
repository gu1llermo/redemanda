import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/widgets.dart';
import '../widgets/widgets.dart';

class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
      ),
      appBar: AppBar(
        title: const Text('Documentos'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded))
        ],
      ),
      body: const _DocumentsView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo documento'),
        icon: const Icon(Icons.note_add),
        onPressed: () {
          context.push('/document/new');
        },
      ),
    );
  }
}

class _DocumentsView extends ConsumerWidget {
  const _DocumentsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40, top: 10),
      child: GridView.builder(
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisExtent: 170,
        ),
        itemBuilder: (context, index) {
          return DocumentCard(
            title: 'Lorem exercitation veniam Lorem irure non. Index: $index',
            description:
                'Adipisicing ut duis veniam pariatur exercitation sint nisi officia anim aliquip nisi dolor. Enim id sit reprehenderit laboris magna qui nostrud dolore excepteur laboris ut. Ea et tempor in nulla. Fugiat ullamco sint eu id dolore. Aute anim tempor in Lorem id ut est. Descripción Documento nro $index',
            creationDate: DateTime.now(),
          );
        },
        itemCount: 50,
      ),
    );
  }
}
