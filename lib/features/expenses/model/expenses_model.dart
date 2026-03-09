class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String property;
  final String unit;
  final String description;
  final List<String> attachments;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.property,
    required this.unit,
    required this.description,
    required this.attachments,
  });
}