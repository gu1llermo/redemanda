import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'providers.dart';

part 'user_credits_provider.g.dart';

@Riverpod(dependencies: [FixedCredits, AdditionalCredits])
Stream<int> userCredits(Ref ref, String userId) async* {
  final controller = StreamController<int>();

  int fixedCredits = 0;
  int additionalCredits = 0;

  ref.listen(fixedCreditsProvider(userId), (previous, next) {
    fixedCredits = next.value ?? 0;
    controller.add(fixedCredits + additionalCredits);
  });

  ref.listen(additionalCreditsProvider(userId), (previous, next) {
    additionalCredits = next.value ?? 0;
    controller.add(fixedCredits + additionalCredits);
  });

  await for (final total in controller.stream) {
    yield total;
  }

  ref.onDispose(() {
    controller.close();
  });
}
