import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../shared/shared.dart';

class CheckOutStatusScreen extends StatefulWidget {
  const CheckOutStatusScreen({super.key});

  @override
  State<CheckOutStatusScreen> createState() => _CheckOutStatusScreenState();
}

class _CheckOutStatusScreenState extends State<CheckOutStatusScreen> {
  @override
  void initState() {
    super.initState();

    ServiceWorkerUpdateManager.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
