import 'package:flutter/material.dart';
import 'package:tob/core/utils/components/app_button.dart';
import 'package:tob/features/add_property/utils/alt_text_field.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: const Text("Expenses"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                AltTextField(
                  type: AltFieldType.dropdown,
                  label: "Property",
                  hint: "Select property to repair/renovate",
                  items: [],
                  onChanged: (value) {},
                ),
                AltTextField(
                  type: AltFieldType.dropdown,
                  label: "Unit",
                  hint: "Select unit to repair/renovate",
                  items: [],
                  onChanged: (value) {},
                ),
                AltTextField(
                  type: AltFieldType.dropdown,
                  label: "Expenses Type",
                  hint: "Select expenses type",
                  items: [],
                  onChanged: (value) {},
                ),
                AltTextField(
                  type: AltFieldType.text,
                  label: "Money Spent",
                  hint: "Select money spent",
                  items: [],
                  onChanged: (value) {},
                ),
                AltTextField(
                  type: AltFieldType.multiline,
                  label: "Description",
                  hint: "Enter description",
                  maxLines: 4,
                  onChanged: (value) {},
                ),
            
                const SizedBox(height: 20),
            
                Text("Add Photo of Expenses", style: theme.textTheme.titleMedium),
            
                const SizedBox(height: 10),
            
                Row(
                  children: List.generate(
                    3,
                    (index) => Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 90,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
            
                const SizedBox(height: 30),
             
                ],
              ),
            ),
            AppButton(title: "Update", onPressed: () {}),
          ],
        ),
      ),
    );
  }

 
}
