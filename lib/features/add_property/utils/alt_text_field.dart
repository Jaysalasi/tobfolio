import 'package:flutter/material.dart';

enum AltFieldType { text, dropdown, password, multiline, number }

class AltTextField extends StatefulWidget {
  final String label;
  final String hint;
  final String? value;
  final AltFieldType type;
  final List<String>? items;
  final Function(String)? onChanged;
  final Function()? onTap;
  final int maxLines;
  final bool enabled;
  final String? prefix;

  const AltTextField({
    super.key,
    required this.label,
    required this.hint,
    this.value,
    this.type = AltFieldType.text,
    this.items,
    this.enabled = true,
    this.onChanged,
    this.onTap,
    this.maxLines = 1,
    this.prefix,
  });

  @override
  State<AltTextField> createState() => _AltTextFieldState();

  
}

class _AltTextFieldState extends State<AltTextField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  bool get isDropdown => widget.type == AltFieldType.dropdown;

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlay();
      Overlay.of(context).insert(_overlayEntry!);
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  @override
void dispose() {
  _overlayEntry?.remove();
  super.dispose();
}

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          /// Detect taps outside dropdown
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _toggleDropdown,
            ),
          ),

          /// Dropdown
          Positioned(
            width: size.width,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, size.height - 40),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.items?.length ?? 0,
                    itemBuilder: (context, index) {
                      final item = widget.items![index];

                      return InkWell(
                        onTap: () {
                          widget.onChanged?.call(item);
                          _toggleDropdown();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),

        CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            enabled: widget.enabled,
            initialValue: widget.value,
            readOnly: isDropdown,
            maxLines: widget.type == AltFieldType.multiline
                ? widget.maxLines
                : 1,
            obscureText: widget.type == AltFieldType.password,
            keyboardType: widget.type == AltFieldType.number
                ? TextInputType.number
                : TextInputType.text,
            onTap: isDropdown ? _toggleDropdown : widget.onTap,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
              hintText: widget.hint,
              filled: true,
              fillColor: Colors.white,
              suffixIcon: isDropdown
                  ? const Icon(Icons.keyboard_arrow_down)
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}
