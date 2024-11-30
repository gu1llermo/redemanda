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
        actions: [
          // IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
          _OptionButton()
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

class _OptionButton extends StatelessWidget {
  const _OptionButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.search),
      tooltip: 'Buscar',
      onSelected: (String choice) {
        switch (choice) {
          case 'searchByDate':
            // Lógica de búsqueda por fecha
            print('Buscar por fecha');
            break;
          case 'searchByName':
            // Lógica de búsqueda por nombre
            print('Buscar por nombre');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'searchByDate',
          child: ListTile(
            leading: Icon(Icons.calendar_month),
            title: Text('Buscar por fecha'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'searchByName',
          child: ListTile(
            leading: Icon(Icons.text_fields),
            title: Text('Buscar por nombre'),
          ),
        ),
      ],
    );
  }
}
