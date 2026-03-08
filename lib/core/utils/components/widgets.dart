import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tob/core/utils/components/constants.dart';

Widget plusButtonMeth({
  required String label,
  required ThemeData theme,
  Function()? onTap,
  bool isIcon = true,
  TextStyle? textStyle,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(9.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isIcon)
            Icon(Icons.add, size: 14, color: theme.scaffoldBackgroundColor),
          Text(
            label,
            style: textStyle ?? theme.textTheme.bodySmall?.copyWith(
              color: theme.scaffoldBackgroundColor,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget homeCardMeth({
  required String icon,
  required String title,
  required ThemeData theme,
  required BuildContext context,
  String? subtitle,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
}) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: appGradient(context),
      boxShadow: appShadow(context),
      borderRadius: BorderRadius.circular(25),
    ),
    child: Column(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        SvgPicture.asset(icon),
        SizedBox(height: 5),
        Text(
          title,
          style: theme.textTheme.bodyMedium?.copyWith(
            // fontWeight: FontWeight.bold,
          ),
        ),
        // SizedBox(height: 10),
        if (subtitle != null)
          Text(
            subtitle,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    ),
  );
}


Container shadowContainerMeth({
    required BuildContext context,
    required ThemeData theme,
    required Widget child,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        gradient: appGradient(context),
        boxShadow: appShadow(context),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }