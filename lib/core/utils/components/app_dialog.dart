import 'package:flutter/material.dart';

class AppDialog extends StatefulWidget {
  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;
  final ShapeBorder? shape;

  const AppDialog({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.contentPadding,
    this.width,
    this.shape,
  });

  @override
  State<AppDialog> createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Dialog(
        backgroundColor: Colors.transparent,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.width ?? 400,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.title != null) ...[
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.title!,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Divider(height: 1),
                ],
                Flexible(
                  child: Padding(
                    padding: widget.contentPadding ?? const EdgeInsets.all(20),
                    child: widget.child,
                  ),
                ),
                if (widget.actions != null && widget.actions!.isNotEmpty) ...[
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: widget.actions!,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}