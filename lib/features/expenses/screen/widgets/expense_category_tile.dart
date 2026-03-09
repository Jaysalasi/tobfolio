import 'package:flutter/material.dart';
import 'package:tob/core/utils/components/constants.dart';

class ExpenseCategoryTile extends StatelessWidget {
  final String title;
  final String amount;

  const ExpenseCategoryTile({
    super.key,
    required this.title,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: appShadow(context)
      ),
      child: Row(
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16)),
          const Spacer(),
          Text(amount,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              )),
        ],
      ),
    );
  }
}