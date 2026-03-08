import 'package:tob/features/add_property/utils/add_property_utils.dart';

class AddPropertyState {
  final String name;
  final String address;
  final String propertyType;
  final String unitType;
  final List<PropertyPhoto> photos;
  final String document;

  AddPropertyState({
    this.name = '',
    this.address = '',
    this.propertyType = '',
    this.unitType = '',
    this.photos = const [],
    this.document = '',
  });

  AddPropertyState copyWith({
    String? name,
    String? address,
    String? propertyType,
    String? unitType,
    List<PropertyPhoto>? photos,
    String? document,
  }) {
    return AddPropertyState(
      name: name ?? this.name,
      address: address ?? this.address,
      propertyType: propertyType ?? this.propertyType,
      unitType: unitType ?? this.unitType,
      photos: photos ?? this.photos,
      document: document ?? this.document,
    );
  }
}
