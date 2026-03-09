import 'package:flutter/material.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';
import 'package:tob/features/expenses/screen/add_expense.dart';
import 'package:tob/features/expenses/screen/widgets/expense_category_tile.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.tertiary,
        title: Text("Expenses", style: theme.textTheme.titleLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              /// TOTAL EXPENSE CARD
              Container(
                padding:  EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: appShadow(context),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text("Total Expenses", style: theme.textTheme.bodyLarge),
                        const SizedBox(height: 6),
                        Text(
                          "\$17,000",
                          style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                    const Spacer(),
                    plusButtonMeth(label: "Add Expense", theme: theme, onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddExpenseScreen()));
                    })
                  ],
                ),
              ),
          
              const SizedBox(height: 16),
          
              const ExpenseCategoryTile(
                  title: "Fix & Repairs", amount: "\$3"),
          
              const ExpenseCategoryTile(
                  title: "Utility & Bills", amount: "\$3"),
          
              const ExpenseCategoryTile(
                  title: "PM Fee", amount: "\$3"),
          
              const ExpenseCategoryTile(
                  title: "Insurance", amount: "\$3"),
          
              Row(children: [
                Text("Maintenance History", style: theme.textTheme.headlineSmall),
                const Spacer(),
                TextButton(onPressed: () {}, child: Text("View All", style: theme.textTheme.bodyMedium?.copyWith(color: AppTheme.accentColor))),
              ],),
              Column(
                children: [1,2,3,4,5].asMap().entries.map((entry) {
                  return Container(
                    margin:  EdgeInsets.symmetric( vertical: 8),
                    padding:  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: appShadow(context),
                    ),
                    child: Row(children: [
                      Image.asset(AppImages.logoFramed, width: 40, height: 40),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Each room painted and doors changed".length > 20 ? "${"Each room painted and doors changed".substring(0, 20)}..." : "Each room painted and doors changed", style: theme.textTheme.bodyLarge),
                          Text("Oct 12, 2025", style: theme.textTheme.bodySmall),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("N 340,000", style: theme.textTheme.bodyLarge),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.green.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("Successful", style: theme.textTheme.bodySmall?.copyWith(color: AppTheme.green, fontSize: 10)),
                          ),
                        ],
                      )
                    ],),
                  );
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}