import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/config.dart';
import '../../../auth/presentation/providers/providers.dart';
import '../../../credits/credits.dart';
import '../../../shared/widgets/widgets.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final userId = ref.watch(authProvider).user?.id;

    return Scaffold(
      drawer: SideMenu(
        scaffoldKey: scaffoldKey,
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            //const Text('Redemanda'),
            const UserCreditsWidget(),
          ],
        ),
        actions: [SearchOptionButton()],
      ),
      body: const _DocumentsView(),
      floatingActionButton: userId == null
          ? const SizedBox.shrink()
          : ref.watch(userCreditsProvider(userId)).when(
                data: (credits) => FloatingActionButton.extended(
                  label: const Text('Nuevo documento'),
                  icon: const Icon(Icons.note_add),
                  onPressed: () {
                    if (credits > 0) {
                      context.push('/new-document');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'No tienes créditos suficientes para crear un nuevo documento'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                ),
                loading: () => const FloatingActionButton.extended(
                  label: Text('Cargando...'),
                  icon: Icon(Icons.hourglass_empty),
                  onPressed: null,
                ),
                error: (error, stackTrace) => FloatingActionButton.extended(
                  label: const Text('Error'),
                  icon: const Icon(Icons.error),
                  onPressed: null,
                ),
              ),
    );
  }
}

class _DocumentsView extends ConsumerWidget {
  const _DocumentsView();

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
          await documentsNotifier.refreshDocuments();
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
        },
        child: documentsState.isLoading
            ? Center(child: CircularProgressIndicator())
            : MasonryGridView.builder(
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
