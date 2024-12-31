import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../delegates/delegates.dart';
import '../providers/providers.dart';

class SearchOptionButton extends ConsumerWidget {
  const SearchOptionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
        tooltip: 'Buscar',
        onPressed: () {
          final documentsNotifier =
              ref.read(documentsPaginationProvider.notifier);
          final delegate = DocumentSearchDelegate(
            ref: ref,
            searchType: SearchType.name,
            onSearchByName: documentsNotifier.searchDocumentsByTerm,
            onSearchByDateRange: documentsNotifier.searchDocumentsByRange,
          );

          showSearch(context: context, delegate: delegate);
        },
        icon: const Icon(Icons.search));
  }
}
