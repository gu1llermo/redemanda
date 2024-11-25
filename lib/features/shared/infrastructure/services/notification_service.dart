import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

enum FlushbarType {
  success,
  error,
  warning,
  info,
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  NotificationService._internal();

  Flushbar? _currentFlushbar;

  void showNotification({
    required BuildContext context,
    required String message,
    String? title,
    FlushbarType type = FlushbarType.info,
  }) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case FlushbarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
        break;
      case FlushbarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
        break;
      case FlushbarType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
        break;
      default:
        backgroundColor = Colors.blue;
        icon = Icons.info;
    }

    _currentFlushbar?.dismiss();

    _currentFlushbar = Flushbar(
      message: message,
      title: title,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(20),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeInCirc,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      isDismissible: true,
      // Puedes agregar un botón si gustas
      // mainButton: TextButton(
      //   child: const Text(
      //     'DESHACER',
      //     style: TextStyle(color: Colors.white),
      //   ),
      //   onPressed: () {
      //     // Acción al presionar el botón
      //     // Ocultar el Flushbar inmediatamente
      //     _currentFlushbar?.dismiss();
      //     // Aquí puedes agregar cualquier otra acción que quieras realizar
      //   },
      // ),
    );
    // Mostrar el Flushbar
    _currentFlushbar!.show(context);
  }

  void dismissCurrentNotification() {
    _currentFlushbar?.dismiss();
    _currentFlushbar = null;
  }
}
