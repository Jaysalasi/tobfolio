import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isActive;
  final double height;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? disabledColor;
  final Color? textColor;
  final Widget? prefix;

  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.isLoading = false,
    this.isActive = true,
    this.height = 55,
    this.borderRadius = 16,
    this.backgroundColor,
    this.disabledColor,
    this.textColor,
    this.prefix,
  });

  bool get _isDisabled => !isActive || onPressed == null;

  @override
  Widget build(BuildContext context) {
    final bgColor = _isDisabled
        ? (disabledColor ?? Colors.grey.shade400)
        : (backgroundColor ?? Colors.black);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: _isDisabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (prefix != null) ...[
                    prefix!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}