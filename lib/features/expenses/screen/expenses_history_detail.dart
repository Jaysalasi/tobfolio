import 'package:flutter/material.dart';
import 'package:tob/core/utils/components/widgets.dart';

class ExpensesHistoryDetail extends StatelessWidget {
  const ExpensesHistoryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: const Text("Expense History"),
        actions: [
          plusButtonMeth(
            label: "Share",
            isIcon: false,
            theme: theme,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            textStyle: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onPrimary,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
