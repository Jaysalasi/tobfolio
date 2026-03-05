import 'package:tob/features/add_property/utils/add_property_utils.dart';

class AddPropertyState {
  final String name;
  final String address;
  final String propertyType;
  final List<PropertyPhoto> photos;

  AddPropertyState({
    this.name = '',
    this.address = '',
    this.propertyType = '',
    this.photos = const [],
  });

  AddPropertyState copyWith({
    String? name,
    String? address,
    String? propertyType,
    List<PropertyPhoto>? photos,
  }) {
    return AddPropertyState(
      name: name ?? this.name,
      address: address ?? this.address,
      propertyType: propertyType ?? this.propertyType,
      photos: photos ?? this.photos,
    );
  }
}