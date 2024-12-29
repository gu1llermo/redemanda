import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/shared.dart';
import '../../domain/domain.dart';
import '../providers/providers.dart';

class DocumentCard extends StatelessWidget {
  final Document document;

  const DocumentCard({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final title = document.title;
    final description = document.description;
    final creationDate = document.createdAt;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Center(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleLarge,
                      // style: const TextStyle(
                      //   fontSize: 18,
                      //   fontWeight: FontWeight.bold,
                      // ),
                    ),
                  ),
                ),
                _OptionButton(document),
              ],
            ),

            // Contenido de la tarjeta

            GestureDetector(
              onTap: () => FileUtils.openWithDefaultApp(
                context: context,
                fileBytes: document.docxFile,
                fileExtension: 'docx', // sin el punto
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleCard(
                    document: document,
                  ),
                  Expanded(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //const SizedBox(height: 8),
                        Text(
                          description,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                '${creationDate.day}/${creationDate.month}/${creationDate.year}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Botón de opciones
            // IconButton(
            //   icon: const Icon(Icons.more_vert),
            //   onPressed: () => _showOptionsMenu(context),
            // ),
          ],
        ),
      ),
    );
  }
}

class _CircleCard extends ConsumerWidget {
  const _CircleCard({
    // required this.colors,
    required this.document,
  });

  // final ColorScheme colors;
  // final String title;
  // final int productId;
  final Document document;

  String getIniciales(String title) {
    title = title.trim();
    if (title.isEmpty) return title;
    if (title.contains(' ')) {
      final index = title.indexOf(' ') + 1;
      return '${title[0]}${title[index]}'.toUpperCase();
    } else {
      return title.substring(0, 2).toUpperCase();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final title = document.title;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CircleAvatar(
        radius: 30,
        // backgroundColor: Colors.transparent,
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                colors.onPrimaryContainer,
                colors.primaryContainer,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Text(
              getIniciales(title),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionButton extends ConsumerWidget {
  const _OptionButton(this.document);
  final Document document;

  Future<void> mostrarDialogoConfirmacionEliminarDocumento({
    required BuildContext context,
    required WidgetRef ref,
    required int id,
  }) async {
    bool? confirmacion = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_outlined,
                  color: Colors.orange,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  'Eliminar Archivo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '¿Está seguro de que desea eliminar el archivo seleccionado? Esta acción no se puede deshacer.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        context.pop(false);
                      },
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        context.pop(true);
                      },
                      child: Text('Eliminar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    // Procesa la respuesta del usuario
    if (confirmacion == true) {
      // Lógica para eliminar el archivo
      ref.read(documentsPaginationProvider.notifier).deleteDocument(id);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (String choice) {
        switch (choice) {
          case 'share':
            FileUtils.share(
              context: context,
              file: document.docxFile,
              fileName: '${document.title}.docx',
            );
            break;
          case 'delete':
            mostrarDialogoConfirmacionEliminarDocumento(
              context: context,
              ref: ref,
              id: document.id!,
            );
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'share',
          child: ListTile(
            leading: Icon(Icons.share),
            title: Text('Compartir'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'delete',
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Eliminar'),
          ),
        ),
      ],
    );
  }
}
