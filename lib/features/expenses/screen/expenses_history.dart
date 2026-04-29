import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/currency_formatter.dart';
import 'package:tobfolio/features/expenses/model/expenses_model.dart';
import 'package:tobfolio/features/expenses/screen/expenses_history_detail.dart';
import 'package:tobfolio/features/expenses/screen/widgets/expense_widgets.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';

class ExpensesHistory extends StatefulWidget {
  final List<ExpensesModel> expenses;
  const ExpensesHistory({super.key, required this.expenses});

  @override
  State<ExpensesHistory> createState() => _ExpensesHistoryState();
}

class _ExpensesHistoryState extends State<ExpensesHistory> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeBloc>().add(LoadHomeData());
    });
  }

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
          children: widget.expenses.isEmpty
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
              : widget.expenses.map((expense) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ExpensesHistoryDetail(expenseDetail: expense),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (expense.description?.length ?? 0) > 30
                                      ? "${expense.description!.substring(0, 30)}..."
                                      : expense.description ?? 'No description',
                                  style: theme.textTheme.bodyLarge,
                                ),
                                Text(
                                  expense.type ?? 'Unknown type',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                CurrencyFormatter.formatCurrency(
                                  expense.cost?.toStringAsFixed(2) ?? '0.00',
                                  currencyCode: context
                                      .read<HomeBloc>()
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
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  expense.status ?? 'Unknown',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: getStatusColor(expense.status),
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
      ),
    );
  }
}
