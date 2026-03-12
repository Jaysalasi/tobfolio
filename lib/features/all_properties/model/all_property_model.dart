class PropertyModel {
  final String id;
  final String name;
  final String address;
  final String type;
  final double income;
  final double expenses;
  final List<String> images;

  PropertyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.type,
    required this.income,
    required this.expenses,
    required this.images,
  });
}