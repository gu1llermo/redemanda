// Mixin para mantener vivas las páginas
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

mixin KeepPageAliveMixin<T extends ConsumerStatefulWidget>
    on ConsumerState<T>, AutomaticKeepAliveClientMixin<T> {
  @override
  bool get wantKeepAlive => true;
}
