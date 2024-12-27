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
}
