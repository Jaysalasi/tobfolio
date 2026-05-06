import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/core/theme/app_theme.dart';
import 'package:tobfolio/core/utils/components/constants.dart';
import 'package:tobfolio/core/utils/components/widgets.dart';
import 'package:tobfolio/core/utils/constants/assets/pngs.dart';
import 'package:tobfolio/core/utils/currency_formatter.dart';
import 'package:tobfolio/features/expenses/model/expenses_model.dart';
import 'package:tobfolio/features/home/bloc/home_bloc.dart';

class ExpensesHistoryDetail extends StatefulWidget {
  final ExpensesModel expenseDetail;
  const ExpensesHistoryDetail({super.key, required this.expenseDetail});

  @override
  State<ExpensesHistoryDetail> createState() => _ExpensesHistoryDetailState();
}

class _ExpensesHistoryDetailState extends State<ExpensesHistoryDetail> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    print((widget.expenseDetail));
    // final size = MediaQuery.of(context).size;
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  // color: theme.colorScheme.surface,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white,
                    boxShadow: appShadow(context),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20,
                    children: [
                      // SizedBox(height: 20),
                      Center(
                        child: Column(
                          spacing: 20,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(AppImages.logoFramed),
                            Text(
                         CurrencyFormatter.formatCurrency(
                          widget.expenseDetail.cost.toString(),
                          currencyCode: context
                              .watch<HomeBloc>()
                              .state
                              .user
                              ?.currency,
                        ),
                              
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              widget.expenseDetail.status!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      rowText(
                        theme: theme,
                        title: "Property Name",
                        subtitle: widget.expenseDetail.propertyId!.name!,
                      ),
                      rowText(
                        theme: theme,
                        title: "Amount Spent",
                        subtitle:
                         CurrencyFormatter.formatCurrency(
                          widget.expenseDetail.cost.toString(),
                          currencyCode: context
                              .watch<HomeBloc>()
                              .state
                              .user
                              ?.currency,
                        ),
                      ),
                      rowText(
                        theme: theme,
                        title: "Date",
                        subtitle: "Nov 15th, 2025",
                      ),
                      rowText(
                        theme: theme,
                        title: "Unit",
                        subtitle: widget.expenseDetail.type!,
                      ),
                      rowText(
                        theme: theme,
                        title: "Description",
                        subtitle: widget.expenseDetail.description!,
                      ),

                      // Text(
                      //   "Attachments",
                      //   style: theme.textTheme.bodyLarge?.copyWith(
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      //   textAlign: TextAlign.left,
                      // ),

                      // Container(
                      //   decoration: BoxDecoration(
                      //     color: Colors.white,
                      //     // borderRadius: BorderRadius.circular(8),
                      //     // border: Border.all(color: AppTheme.grey),
                      //   ),
                      //   child: Row(
                      //     spacing: 5,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       ClipRRect(
                      //         borderRadius: BorderRadius.circular(6),
                      //         child: Image.asset(
                      //           AppImages.worker1,
                      //           width: size.width * 0.255,
                      //           height: size.width * 0.255,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //       ClipRRect(
                      //         borderRadius: BorderRadius.circular(6),
                      //         child: Image.asset(
                      //           AppImages.worker1,
                      //           width: size.width * 0.255,
                      //           height: size.width * 0.255,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //       ClipRRect(
                      //         borderRadius: BorderRadius.circular(6),
                      //         child: Image.asset(
                      //           AppImages.worker1,
                      //           width: size.width * 0.255,
                      //           height: size.width * 0.255,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row rowText({
    required ThemeData theme,
    required String title,
    required String subtitle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: theme.textTheme.bodyMedium),
        Expanded(
          child: Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
