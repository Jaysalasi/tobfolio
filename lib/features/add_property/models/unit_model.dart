class PropertyUnit {
  final String unitType;
  final int unitNumber;
  final String? description;
  final String? documentPath;
  final List<String> photos;

  PropertyUnit({
    required this.unitType,
    required this.unitNumber,
    this.description,
    this.documentPath,
    this.photos = const [],
  });

  PropertyUnit copyWith({
    String? unitType,
    int? unitNumber,
    String? description,
    String? documentPath,
    List<String>? photos,
  }) {
    return PropertyUnit(
      unitType: unitType ?? this.unitType,
      unitNumber: unitNumber ?? this.unitNumber,
      description: description ?? this.description,
      documentPath: documentPath ?? this.documentPath,
      photos: photos ?? this.photos,
    );
  }
}
