import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:go_router/go_router.dart';
import 'package:service_worker/window.dart' as sw;
import 'package:service_worker/worker.dart';
import 'dart:html' as html;

class ServiceWorkerUpdateManager {
  static void init(BuildContext context) {
    if (!kIsWeb) return;
    // Verificar si el navegador soporta Service Workers
    if (!sw.isSupported) return;
    // Registrar el Service Worker
    _registerServiceWorker(context);
  }

  static Future<void> _registerServiceWorker(BuildContext context) async {
    if (!context.mounted) return;
    try {
      // Registrar el Service Worker
      final registration = await sw.register('/flutter_service_worker.js');

      // Escuchar actualizaciones
      registration.onUpdateFound.listen((_) {
        _showUpdateDialog(context, registration);
      });

      // Verificar si hay una actualización inmediatamente después del registro
      _checkForUpdate(context, registration);
    } catch (e) {
      print('Error registrando Service Worker: $e');
    }
  }

  static void _checkForUpdate(
      BuildContext context, ServiceWorkerRegistration registration) {
    if (!context.mounted) return;
    registration.update().then((_) {
      // Verificar si hay una nueva versión
      if (registration.waiting != null) {
        _showUpdateDialog(context, registration);
      }
    });
  }

  static void _showUpdateDialog(
      BuildContext context, ServiceWorkerRegistration registration) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Actualización Disponible'),
          content: const Text(
              'Hay una nueva versión de la aplicación disponible. ¿Deseas actualizar?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Actualizar'),
              onPressed: () {
                // Activar la nueva versión del Service Worker
                registration.waiting?.postMessage('skipWaiting');

                // Recargar la página para aplicar la actualización
                html.window.location.reload();
              },
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
