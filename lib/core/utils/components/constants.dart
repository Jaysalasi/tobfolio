import 'package:flutter/material.dart';

List<BoxShadow>? appShadow(BuildContext context) {
  return [
    BoxShadow(
      color: Theme.of(context).primaryColor.withValues(alpha: 0.07),
      blurRadius: 15,
      offset: const Offset(0, 5),
    ),
  ];
}

Gradient? appGradient(BuildContext context) {
  return LinearGradient(
    colors: [
      Theme.of(context).colorScheme.surface,
      Theme.of(context).colorScheme.surface,
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
