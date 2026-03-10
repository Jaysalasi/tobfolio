  import 'package:flutter/material.dart';
import 'package:tob/core/theme/app_theme.dart';
import 'package:tob/core/utils/components/constants.dart';
import 'package:tob/core/utils/constants/assets/pngs.dart';

Widget expenseCardMeth(BuildContext context, ThemeData theme, VoidCallback? onTap) {
    return GestureDetector(
                  onTap: onTap ,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: appShadow(context),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.logoFramed,
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Each room painted and doors changed".length > 20
                                  ? "${"Each room painted and doors changed".substring(0, 20)}..."
                                  : "Each room painted and doors changed",
                              style: theme.textTheme.bodyLarge,
                            ),
                            Text(
                              "Oct 12, 2025",
                              style: theme.textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("N 340,000", style: theme.textTheme.bodyLarge),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 5,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "Successful",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: AppTheme.green,
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
  }
