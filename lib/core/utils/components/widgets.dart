import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/constants/assets/svg.dart';

Widget plusButtonMeth({
  required String label,
  required ThemeData theme,
  Function()? onTap,
  bool isIcon = true,
  String icon = SvgAssets.plus,
  TextStyle? textStyle,
  EdgeInsets? padding,
  double borderRadius = 9.5
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.primaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isIcon)
            SvgPicture.asset(icon),
          Text(
            label,
            style:
                textStyle ??
                theme.textTheme.bodyMedium?.copyWith(
                  color: theme.scaffoldBackgroundColor,
                  fontWeight: FontWeight.w500,
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
  VoidCallback? onTap,
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.start,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
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
          // SizedBox(height: 1),
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

InputDecoration altInputDecoration({
  String? hint,
  Widget? prefix,
  Widget? suffix,
}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: prefix,
    suffixIcon: suffix,
    filled: true,
    fillColor: const Color(0xffF3F4F6),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    ),
  );
}
