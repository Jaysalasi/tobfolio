import 'package:flutter/material.dart';

class AltTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  const AltTextField({
    super.key,
    required this.label,
    required this.hint,
    this.value,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(label, style: theme.textTheme.headlineSmall?.copyWith(fontSize: 18, fontWeight: FontWeight.bold),),

        const SizedBox(height: 6),

        TextFormField(
          initialValue: value,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            suffixIcon: readOnly
                ? const Icon(Icons.keyboard_arrow_down)
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
          ),
        ),

        const SizedBox(height: 18)
      ],
    );
  }
}