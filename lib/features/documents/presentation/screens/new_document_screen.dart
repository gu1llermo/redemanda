import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewDocumentScreen extends ConsumerWidget {
  const NewDocumentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nuevo Documento')),
      body: Container(),
    );
  }
}
