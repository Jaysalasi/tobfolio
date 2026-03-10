import 'package:flutter/material.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({super.key});

  @override
  State<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
      backgroundColor: theme.colorScheme.tertiary,
        title: const Text("Security"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  AltTextField(label: "Current Password", hint: "password"),
                  AltTextField(label: "New Password", hint: "password"),
                  AltTextField(label: "Confirm Password", hint: "password"),
                ],
              ),
            )
            ,
            AppButton(title: "Save", onPressed: () {}),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}