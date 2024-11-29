import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      child: MasonryGridView.builder(
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          // mainAxisExtent: 170,
        ),
        itemBuilder: (context, index) {
          return DocumentCard(
            title: 'Pedro Pérez',
            description:
                'Aliqua ex enim do duis id esse irure do sit. Mollit ex eiusmod ea enim aliquip deserunt est voluptate Lorem aliqua. Ea esse occaecat aliqua minim in aliqua. Elit fugiat duis consequat ad sit esse officia commodo adipisicing cillum minim eiusmod nisi. Nulla excepteur occaecat consectetur anim. Quis ad id id deserunt anim.',
            creationDate: DateTime.now(),
          );
        },
        itemCount: 50,
      ),
    );
  }
}
