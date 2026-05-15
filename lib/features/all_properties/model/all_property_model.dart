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
  final String? managementType;
  final String? unitType;
  final String? unitNumber;
  final int? totalUnits;
  final String? unitDescription;

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
    this.managementType,
    this.unitType,
    this.unitNumber,
    this.totalUnits,
    this.unitDescription,
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
      managementType: json['managementType'] as String?,
      unitType: json['unitType'] as String?,
      unitNumber: json['unitNumber'] as String?,
      totalUnits: (json['totalUnits'] as num?)?.toInt(),
      unitDescription: json['unitDescription'] as String?,
    );
  }
}