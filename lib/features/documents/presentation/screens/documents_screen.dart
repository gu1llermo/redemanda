import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:redemanda/features/documents/domain/domain.dart';

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
        actions: [SearchOptionButton()],
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
        ),
        itemBuilder: (context, index) {
          var nombre = lorem(paragraphs: 1, words: 4);
          var description = lorem(paragraphs: 2, words: 30);
          var document = Document.empty(
            title: nombre,
            description: description,
          );
          return DocumentCard(
            document: document,
          );
        },
        itemCount: 50,
      ),
    );
  }
}
