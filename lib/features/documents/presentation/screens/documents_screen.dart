import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:redemanda/features/documents/documents.dart';

import '../../../../config/config.dart';
import '../../../auth/presentation/providers/providers.dart';
import '../../../credits/credits.dart';
import '../../../shared/shared.dart';
import '../providers/providers.dart';

// Provider para el servicio de plataforma
final platformServiceProvider = Provider<PlatformService>((ref) {
  return getPlatformService();
});

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  static const List<Widget> _widgetOptions = [
    _DocumentsView(),
    _CreateDocuments()
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    // final userId = ref.watch(authProvider).user?.id;
    final documentsState = ref.watch(documentsPaginationProvider);
    final selectedIndex = documentsState.selectedIndex;

    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const UserCreditsWidget(),
          ],
        ),
        actions: [SearchOptionButton()],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.format_indent_increase_rounded),
              label: 'Plantillas'),
        ],
        currentIndex: selectedIndex,
        onTap: ref.read(documentsPaginationProvider.notifier).onItemTapped,
        selectedItemColor: Colors.amber[800],
      ),
      // body: const _DocumentsView(),
      // floatingActionButton: userId == null
      //     ? const SizedBox.shrink()
      //     : ref.watch(userCreditsProvider(userId)).when(
      //           data: (credits) => FloatingActionButton.extended(
      //             label: const Text('Nuevo documento'),
      //             icon: const Icon(Icons.note_add),
      //             onPressed: () {
      //               if (credits > 0) {
      //                 context.push('/new-document');
      //               } else {
      //                 ScaffoldMessenger.of(context).showSnackBar(
      //                   const SnackBar(
      //                     content: Text(
      //                         'No tienes créditos suficientes para crear un nuevo documento'),
      //                     backgroundColor: Colors.red,
      //                   ),
      //                 );
      //               }
      //             },
      //           ),
      //           loading: () => const FloatingActionButton.extended(
      //             label: Text('Cargando...'),
      //             icon: Icon(Icons.hourglass_empty),
      //             onPressed: null,
      //           ),
      //           error: (error, stackTrace) => FloatingActionButton.extended(
      //             label: const Text('Error'),
      //             icon: const Icon(Icons.error),
      //             onPressed: null,
      //           ),
      //         ),
    );
  }
}

class _DocumentsView extends ConsumerWidget {
  const _DocumentsView();

  Future<void> _handleRefresh(BuildContext context, WidgetRef ref,
      DocumentsState documentsState) async {
    if (kIsWeb) {
      final platformService = ref.read(platformServiceProvider);
      await platformService.reloadPage();
    } else {
      await ref.read(documentsPaginationProvider.notifier).refreshDocuments();
      if (!context.mounted) return;

      Future.delayed(
        Duration(milliseconds: 300),
        () {
          if (documentsState.documents.isEmpty) {
            if (!context.mounted) return;
            AppUtils.showSnackbar(
              context,
              'No hay documentos aún, crea uno',
            );
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsState = ref.watch(documentsPaginationProvider);
    final documentsNotifier = ref.read(documentsPaginationProvider.notifier);

    ref.listen(
      documentsPaginationProvider,
      (previous, next) {
        if (next.errorMessage.isEmpty) return;
        AppErrorsUtils.onError(context, next.errorMessage);
      },
    );

    // Usar NotificationListener para paginación infinita
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        // Cargar más documentos cuando se está a menos del 20% de llegar al final
        // scrollInfo.metrics.extentBefore es la cantidad de contenido ya desplazado
        // scrollInfo.metrics.extentTotal es el tamaño total del contenido desplazable
        if (scrollInfo.metrics.pixels >=
                scrollInfo.metrics.maxScrollExtent * 0.9 &&
            documentsState.hasMoreDocuments &&
            !documentsState.isLoading) {
          documentsNotifier.loadDocuments();
          return true;
        }
        return false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          _handleRefresh(context, ref, documentsState);
        },
        child: documentsState.isLoading
            ? Center(child: CircularProgressIndicator())
            : MasonryGridView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                physics: const AlwaysScrollableScrollPhysics(),
                gridDelegate:
                    const SliverSimpleGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 400,
                ),
                itemBuilder: (context, index) {
                  final document = documentsState.documents[index];
                  return DocumentCard(
                    document: document,
                  );
                },
                itemCount: documentsState.documents.length,
              ),
      ),
    );
  }
}

class _CreateDocuments extends ConsumerWidget {
  const _CreateDocuments();

  static const _plantillas = [
    Plantilla(
      title: NewDocument02Screen.title,
      description: NewDocument02Screen.description,
      path: NewDocument02Screen.path,
    ),
    Plantilla(
      title: NewDocument03Screen.title,
      description: NewDocument03Screen.description,
      path: NewDocument03Screen.path,
    ),
    Plantilla(
      title: NewDocument04Screen.title,
      description: NewDocument04Screen.description,
      path: NewDocument04Screen.path,
    ),
    Plantilla(
      title: NewDocument05Screen.title,
      description: NewDocument05Screen.description,
      path: NewDocument05Screen.path,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(authProvider).user?.id;
    return userId == null
        ? const SizedBox.shrink()
        : ref.watch(userCreditsProvider(userId)).when(
              data: (credits) {
                if (credits > 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ListView.builder(
                      itemCount: _plantillas.length,
                      itemBuilder: (context, index) => Card(
                        child: ListTile(
                          title: Text(_plantillas[index].title),
                          subtitle: Text(_plantillas[index].description),
                          trailing: IconButton(
                              onPressed: () =>
                                  context.push('/${_plantillas[index].path}'),
                              icon: Icon(Icons.navigate_next_rounded)),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text(
                        'No tienes créditos suficientes para crear un nuevo documento'),
                  );
                }
                // return FloatingActionButton.extended(
                //   label: const Text('Nuevo documento'),
                //   icon: const Icon(Icons.note_add),
                //   onPressed: () {
                //     if (credits > 0) {
                //       context.push('/new-document');
                //     } else {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text(
                //               'No tienes créditos suficientes para crear un nuevo documento'),
                //           backgroundColor: Colors.red,
                //         ),
                //       );
                //     }
                //   },
                // );
              },
              loading: () => Center(
                child: const CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => Center(
                child: Text('Error: $error'),
              ),
            );
  }
}

class Plantilla {
  final String title;
  final String description;
  final String path;
  const Plantilla(
      {required this.title, required this.description, required this.path});
}
