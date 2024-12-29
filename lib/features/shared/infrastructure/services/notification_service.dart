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
    Duration duration = const Duration(seconds: 9),
    Widget? customButton, // Añadimos este parámetro
  }) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case FlushbarType.success:
        backgroundColor = Colors.green;
        icon = Icons.check_circle;
      case FlushbarType.error:
        backgroundColor = Colors.red;
        icon = Icons.error;
      case FlushbarType.warning:
        backgroundColor = Colors.orange;
        icon = Icons.warning;
      case FlushbarType.info:
        backgroundColor = Colors.blue;
        icon = Icons.info;
    }

    _currentFlushbar?.dismiss();

    _currentFlushbar = Flushbar(
      message: message,
      title: title,
      duration: duration,
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
      mainButton: customButton ??
          TextButton(
            onPressed: dismissCurrentNotification,
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.white),
            ),
          ),
    );
    // Mostrar el Flushbar
    _currentFlushbar!.show(context);
  }

  void dismissCurrentNotification() {
    _currentFlushbar?.dismiss();
    _currentFlushbar = null;
  }
}
