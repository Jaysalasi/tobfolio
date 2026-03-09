import 'package:flutter/material.dart';

class ExpenseHistoryTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;

  const ExpenseHistoryTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 16,
            child: Icon(Icons.attach_money, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 12, color: Colors.grey),
                )
              ],
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}