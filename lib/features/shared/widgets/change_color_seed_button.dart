import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';

class ChangeColorSeedButton extends ConsumerWidget {
  const ChangeColorSeedButton({super.key});
  //final Color seedColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seedColor = ref.watch(colorPreferencesProvider);
    return IconButton(
        onPressed: () {
          showColorPicker2(context, seedColor, ref);
        },
        icon: Icon(
          Icons.circle,
          color: seedColor,
          size: 30,
        ));
  }

  // Future<dynamic> showColorPicker1(
  //     BuildContext context, Color seedColor, WidgetRef ref) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         key: Key(seedColor.toString()),
  //         titlePadding: const EdgeInsets.all(0),
  //         contentPadding: const EdgeInsets.all(0),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: MediaQuery.of(context).orientation ==
  //                   Orientation.portrait
  //               ? const BorderRadius.vertical(
  //                   top: Radius.circular(500),
  //                   bottom: Radius.circular(100),
  //                 )
  //               : const BorderRadius.horizontal(right: Radius.circular(500)),
  //         ),
  //         content: SingleChildScrollView(
  //           child: HueRingPicker(
  //             pickerColor: seedColor,
  //             onColorChanged:
  //                 ref.read(colorPreferencesProvider.notifier).changeColorSeed,

  //             // displayThumbColor: true,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
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

          // content: Text('Hola'),
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
