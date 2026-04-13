import 'package:flutter/material.dart';
import 'package:tob/core/theme/app_theme.dart';

class InfoTile extends StatelessWidget {
  final String title;
  final String value;
  final bool showDivider;
  final bool isWidget;
  final Widget? valueWidget;

  const InfoTile({
    super.key,
    required this.title,
    required this.value,
    this.showDivider = true,
    this.isWidget = false,
    this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
          child: Row(
            children: [
              Text(
                title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: AppTheme.textsecondary,
                ),
              ),
              const Spacer(),
              if (isWidget && valueWidget != null)
                valueWidget!
              else
                Text(
                value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  color: AppTheme.textsecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: AppTheme.grayAltColor,
              height: 0,
              thickness: 0.8,
            ),
          )
      ],
    );
  }
}


Future<dynamic> statefulBottomSheetMeth({
  required BuildContext context,
  required Widget Function(BuildContext, StateSetter) builder,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return builder(context, setState);
        },
      );
    },
  );
}