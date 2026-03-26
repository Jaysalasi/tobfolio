import 'package:flutter/material.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/components/widgets.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';

class ExpensesHistoryDetail extends StatelessWidget {
  const ExpensesHistoryDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
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
                              "N340,000",
                              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "Successful",
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
                        subtitle: "Lekki House",
                      ),
                      rowText(
                        theme: theme,
                        title: "Amount Spent",
                        subtitle: "N340,000",
                      ),
                      rowText(
                        theme: theme,
                        title: "Date",
                        subtitle: "Nov 15th, 2025",
                      ),
                      rowText(theme: theme, title: "Unit", subtitle: "6"),
                      rowText(
                        theme: theme,
                        title: "Description",
                        subtitle:
                            "lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua ",
                      ),

                      Text(
                        "Attachments",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(8),
                          // border: Border.all(color: AppTheme.grey),
                        ),
                        child: Row(
                          spacing: 5,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                AppImages.worker1,
                                width: size.width * 0.255,
                                height: size.width * 0.255,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                AppImages.worker1,
                                width: size.width * 0.255,
                                height: size.width * 0.255,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.asset(
                                AppImages.worker1,
                                width: size.width * 0.255,
                                height: size.width * 0.255,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
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
