import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../delegates/delegates.dart';
import '../providers/providers.dart';

class SearchOptionButton extends ConsumerWidget {
  const SearchOptionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      icon: const Padding(
        padding: EdgeInsets.only(right: 5),
        child: Icon(Icons.search),
      ),
      tooltip: 'Buscar',
      onSelected: (String choice) async {
        final documentsNotifier =
            ref.read(documentsPaginationProvider.notifier);

        switch (choice) {
          case 'searchByDate':
            final delegate = DocumentSearchDelegate(
              ref: ref,
              searchType: SearchType.date,
              onSearchByName: documentsNotifier.searchDocumentsByTerm,
              onSearchByDateRange: documentsNotifier.searchDocumentsByRange,
            );

            final result = await showSearch(
              context: context,
              delegate: delegate,
            );

            if (result != null) {
              // Handle the selected document
              // You might want to navigate to the document details or perform some action
              debugPrint('searchByDate');
            }
            break;

          case 'searchByName':
            final delegate = DocumentSearchDelegate(
              ref: ref,
              searchType: SearchType.name,
              onSearchByName: documentsNotifier.searchDocumentsByTerm,
              onSearchByDateRange: documentsNotifier.searchDocumentsByRange,
            );

            final result = await showSearch(
              context: context,
              delegate: delegate,
            );

            if (result != null) {
              // Handle the selected document
              // You might want to navigate to the document details or perform some action
              debugPrint('searchByName');
            }
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
