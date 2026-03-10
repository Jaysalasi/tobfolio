import 'package:flutter/material.dart';
import 'package:tob/features/expenses/screen/expenses_history_detail.dart';
import 'package:tob/features/expenses/screen/widgets/expense_widgets.dart';

class ExpensesHistory extends StatefulWidget {
  const ExpensesHistory({super.key});

  @override
  State<ExpensesHistory> createState() => _ExpensesHistoryState();
}

class _ExpensesHistoryState extends State<ExpensesHistory> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
      backgroundColor: theme.colorScheme.tertiary,
        title: Text("Expenses History"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
                  children: [1, 2, 3, 4, 5].asMap().entries.map((entry) {
                    return expenseCardMeth(context, theme, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ExpensesHistoryDetail(),
                        ),
                      );
                    });
                  }).toList(),
                ),
      ),
    );
  }
}