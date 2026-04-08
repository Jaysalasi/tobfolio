class PropertyModel {
  final String id;
  final String name;
  final String address;
  final String type;
  final String landlordId;
  final int units;
  final List<String> propertyImages;
  final double totalRenovationCost;
  final List<dynamic> renovations;
  final String createdAt;

  PropertyModel({
    required this.id,
    required this.name,
    required this.address,
    required this.type,
    required this.landlordId,
    required this.units,
    required this.propertyImages,
    required this.totalRenovationCost,
    required this.renovations,
    required this.createdAt,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['_id'] as String? ?? json['id'] as String,
      name: json['name'] as String? ?? '',
      address: json['address'] as String? ?? '',
      type: json['type'] as String? ?? '',
      landlordId: json['landlordId'] as String? ?? '',
      units: (json['units'] as num?)?.toInt() ?? 0,
      propertyImages: json['propertyImages'] is List 
          ? (json['propertyImages'] as List).map((item) => item.toString()).toList()
          : [],
      totalRenovationCost: (json['totalRenovationCost'] as num?)?.toDouble() ?? 0.0,
      renovations: json['renovations'] as List? ?? [],
      createdAt: json['createdAt'] as String? ?? '',
    );
  }
}