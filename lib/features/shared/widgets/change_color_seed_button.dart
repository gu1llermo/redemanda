import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';

class ChangeColorSeedButton extends ConsumerWidget {
  const ChangeColorSeedButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColor = ref.watch(colorPreferencesProvider);
    final colors = Theme.of(context).colorScheme;
    return IconButton(
        style: IconButton.styleFrom(
          side: BorderSide(
            color: colors.inversePrimary, // Customize border color as needed
            width: 2.0, // 2-pixel border
          ),
          backgroundColor: seedColor,
        ),
        onPressed: () {
          showColorPicker2(context, seedColor, ref);
        },
        icon: Icon(
          Icons.circle,
          color: seedColor,
          //size: 30,
        ));
  }

  Future<dynamic> showColorPicker2(
      BuildContext context, Color seedColor, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(10),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          content: SizedBox(
            width: 350,
            child: ColorPicker(
              color: seedColor,
              onChanged:
                  ref.read(colorPreferencesProvider.notifier).changeColorSeed,
              initialPicker: Picker.wheel,
            ),
          ),
        );
      },
    );
  }
}
