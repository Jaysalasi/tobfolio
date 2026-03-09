import 'package:flutter/material.dart';
import 'package:tob/core/theme/app_theme.dart';

class PhoneTextField extends StatefulWidget {
  final String label;
  final String hint;

  final String phoneNumber;
  final String countryCode;

  final List<String> countryCodes;

  final Function(String phone)? onChanged;
  final Function(String code)? onCountryChanged;

  const PhoneTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.phoneNumber,
    required this.countryCode,
    required this.countryCodes,
    this.onChanged,
    this.onCountryChanged,
  });

  @override
  State<PhoneTextField> createState() => _PhoneTextFieldState();
}

class _PhoneTextFieldState extends State<PhoneTextField> {
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

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
          /// Tap outside
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: _toggleDropdown,
            ),
          ),

          /// Dropdown menu
          Positioned(
            width: 120,
            child: CompositedTransformFollower(
              link: _layerLink,
              offset: Offset(0, size.height - 55),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 200),
                  decoration: BoxDecoration(
                    color: AppTheme.lightSurfaceColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: widget.countryCodes.length,
                    itemBuilder: (context, index) {
                      final code = widget.countryCodes[index];

                      return InkWell(
                        onTap: () {
                          widget.onCountryChanged?.call(code);
                          _toggleDropdown();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          child: Text(
                            code,
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
        const SizedBox(height: 5),

        Container(
          decoration: BoxDecoration(
            color: AppTheme.lightSurfaceColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppTheme.grayAltColor),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              /// COUNTRY CODE DROPDOWN
              CompositedTransformTarget(
                link: _layerLink,
                child: GestureDetector(
                  onTap: _toggleDropdown,
                  child: Row(
                    children: [
                      Text(
                        widget.countryCode,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// PHONE NUMBER INPUT
              Expanded(
                child: TextFormField(
                  initialValue: widget.phoneNumber,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: widget.hint,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  onChanged: widget.onChanged,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}