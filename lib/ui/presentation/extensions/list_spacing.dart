import 'package:flutter/material.dart';

extension WidgetListExt on List<Widget?> {
  /// Add a separator between each widget
  List<Widget> withSpacing(Widget spacing) {
    if (isEmpty) {
      return [const SizedBox.shrink()];
    }

    return map((e) => [if (e != null) e, spacing]) //
        .expand((list) => list)
        .toList()
      ..removeLast();
  }
}
