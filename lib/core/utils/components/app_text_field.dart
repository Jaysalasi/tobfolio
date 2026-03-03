import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final bool readOnly;
  final bool enabled;
  final int? maxLines;
  final int? minLines;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Widget? prefix;
  final Widget? suffix;
  final double borderRadius;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.readOnly = false,
    this.enabled = true,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.validator,
    this.prefix,
    this.suffix,
    this.borderRadius = 20,
    this.onTap,
    this.onChanged,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscure;

  @override
  void initState() {
    _obscure = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: _obscure,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          onTap: widget.onTap,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: const Color(0xffE7EEF9),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            prefixIcon: widget.prefix,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _obscure
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscure = !_obscure;
                      });
                    },
                  )
                : widget.suffix,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}