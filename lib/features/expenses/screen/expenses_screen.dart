import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/components/widgets.dart';
import 'package:tobfolio/core/utils/currency_formatter.dart'; 
import 'package:tobfolio/features/expenses/bloc/expenses_bloc.dart';
import 'package:tobfolio/features/expenses/bloc/expenses_event.dart';
import 'package:tobfolio/features/expenses/bloc/expenses_state.dart';
import 'package:tobfolio/features/expenses/model/expenses_model.dart';
import 'package:tobfolio/features/expenses/screen/add_expense.dart';
import 'package:tobfolio/features/expenses/screen/expenses_history.dart';
import 'package:tobfolio/features/expenses/screen/expenses_history_detail.dart';
import 'package:tobfolio/features/expenses/screen/widgets/expense_category_tile.dart';
import 'package:tobfolio/features/expenses/screen/widgets/expense_widgets.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ExpensesBloc>().add(LoadExpenses());
    });
  }

  Map<String, List<dynamic>> _getExpensesByType(List expenses) {
    final Map<String, List<dynamic>> groupedExpenses = {};

    for (final expense in expenses) {
      final type = expense.type?.toString() ?? 'Other';
      if (!groupedExpenses.containsKey(type)) {
        groupedExpenses[type] = [];
      }
      groupedExpenses[type]!.add(expense);
    }

    return groupedExpenses;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.tertiary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: theme.colorScheme.tertiary,
        title: Text("Expenses", style: theme.textTheme.titleLarge),
      ),
      body: BlocBuilder<ExpensesBloc, ExpensesState>(
        builder: (context, state) {
          if (state is ExpensesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ExpensesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error loading expenses: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ExpensesBloc>().add(LoadExpenses());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is CreateExpensesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error creating expense: ${state.message}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ExpensesBloc>().add(LoadExpenses());
                    },
                    child: const Text('Continue'),
                  ),
                ],
              ),
            );
          }

          final expenses = state is ExpensesLoaded
              ? state.expenses
              : <ExpensesModel>[];
          debugPrint("statee placards  $state");
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  /// TOTAL EXPENSE CARD
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: appShadow(context),
                    ),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Expenses",
                              style: theme.textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              CurrencyFormatter.formatCurrency(
                                expenses.fold<double>(
                                  0,
                                  (sum, expense) =>
                                      sum + (expense.cost?.toDouble() ?? 0.0),
                                ),
                                currencyCode: context
                                    .watch<HomeBloc>()
                                    .state
                                    .user
                                    ?.currency,
                              ),
                              // "\$${expenses.fold<double>(0, (sum, expense) => sum + (expense.cost?.toDouble() ?? 0.0)).toStringAsFixed(2)}",
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        plusButtonMeth(
                          label: "Add Expense",
                          theme: theme,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddExpenseScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Group expenses by type and calculate totals
                  ..._getExpensesByType(expenses).entries.map((entry) {
                    final typeTotal = entry.value.fold<double>(
                      0,
                      (sum, expense) => sum + (expense.cost?.toDouble() ?? 0.0),
                    );
                    return ExpenseCategoryTile(
                      title: entry.key,
                      amount: CurrencyFormatter.formatCurrency(
                        typeTotal.toStringAsFixed(2),
                        currencyCode: context
                            .watch<HomeBloc>()
                            .state
                            .user
                            ?.currency,
                      ),
                      // amount: "\$${typeTotal.toStringAsFixed(2)}",
                    );
                  }),

                  Row(
                    children: [
                      Text(
                        "Expense History",
                        style: theme.textTheme.headlineSmall,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ExpensesHistory(expenses: expenses),
                            ),
                          );
                        },
                        child: Text(
                          "View All",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: expenses.isEmpty
                        ? [
                            Container(
                              padding: const EdgeInsets.all(32),
                              child: Center(
                                child: Text(
                                  'No expenses found',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ]
                        : expenses.map((expense) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExpensesHistoryDetail(
                                      expenseDetail: expense,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: appShadow(context),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: AppTheme.accentColor.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        getExpenseIcon(expense.type),
                                        color: AppTheme.accentColor,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (expense.description?.length ?? 0) >
                                                    30
                                                ? "${expense.description!.substring(0, 30)}..."
                                                : expense.description ??
                                                      'No description',
                                            style: theme.textTheme.bodyLarge,
                                          ),
                                          Text(
                                            expense.type ?? 'Unknown type',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          // "\$${expense.cost?.toStringAsFixed(2) ?? '0.00'}",
                                          CurrencyFormatter.formatCurrency(
                                            expense.cost?.toStringAsFixed(2) ??
                                                '0.00',
                                            currencyCode: context
                                                .watch<HomeBloc>()
                                                .state
                                                .user
                                                ?.currency,
                                          ),
                                          style: theme.textTheme.bodyLarge,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: getStatusColor(
                                              expense.status,
                                            ).withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(
                                              4,
                                            ),
                                          ),
                                          child: Text(
                                            expense.status ?? 'Unknown',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: getStatusColor(
                                                    expense.status,
                                                  ),
                                                  fontSize: 10,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
