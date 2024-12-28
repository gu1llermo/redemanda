import 'package:flutter/material.dart';

import '../../features/shared/shared.dart';

class AppErrorsUtils {
  static void onError(BuildContext context, String errorMessage) {
    if (!context.mounted) return;
    NotificationService().showNotification(
      context: context,
      message: errorMessage,
      title: 'Error',
      type: FlushbarType.error,
    );
  }

  static void onSucces(BuildContext context, String message,
      [Widget? customWidget]) {
    if (!context.mounted) return;
    NotificationService().showNotification(
      context: context,
      message: message,
      type: FlushbarType.success,
      customButton: customWidget,
    );
  }
}
