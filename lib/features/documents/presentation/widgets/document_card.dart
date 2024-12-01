import 'package:flutter/material.dart';

import '../../domain/domain.dart';

class DocumentCard extends StatelessWidget {
  final Document document;

  const DocumentCard({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    var title = document.title;
    var description = document.description;
    var creationDate = document.createdAt;

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
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const _OptionButton(),
              ],
            ),

            // Contenido de la tarjeta

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _CircleCard(colors: colors, title: title),
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
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

class _CircleCard extends StatelessWidget {
  const _CircleCard({
    required this.colors,
    required this.title,
  });

  final ColorScheme colors;
  final String title;

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
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: CircleAvatar(
        radius: 30,
        // backgroundColor: Colors.transparent,
        child: Container(
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

class _OptionButton extends StatelessWidget {
  const _OptionButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (String choice) {
        switch (choice) {
          case 'preview':
            // Lógica de vista previa
            print('Vista previa seleccionada');
            break;
          case 'share':
            // Lógica de compartir
            print('Compartir seleccionada');
            break;
          case 'delete':
            // Lógica de eliminar
            print('Eliminar seleccionada');
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'preview',
          child: ListTile(
            leading: Icon(Icons.preview),
            title: Text('Vista previa'),
          ),
        ),
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
