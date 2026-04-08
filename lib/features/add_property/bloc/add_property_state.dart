import 'package:tob/features/add_property/utils/add_property_utils.dart';

enum AddPropertyStatus {
  initial,
  loading,
  success,
  error,
}

class AddPropertyState {
  final String name;
  final String address;
  final String propertyType;
  final String unitType;
  final String? description;
  final int? unitNumber;
  final List<PropertyPhoto> photos;
  final String document;
  final AddPropertyStatus status;
  final String? errorMessage;

  AddPropertyState({
    this.name = '',
    this.address = '',
    this.propertyType = '',
    this.unitType = '',
    this.description,
    this.unitNumber,
    this.photos = const [],
    this.document = '',
    this.status = AddPropertyStatus.initial,
    this.errorMessage,
  });

  AddPropertyState copyWith({
    String? name,
    String? address,
    String? propertyType,
    String? unitType,
    String? description,
    int? unitNumber,
    List<PropertyPhoto>? photos,
    String? document,
    AddPropertyStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AddPropertyState(
      name: name ?? this.name,
      address: address ?? this.address,
      propertyType: propertyType ?? this.propertyType,
      unitType: unitType ?? this.unitType,
      description: description ?? this.description,
      unitNumber: unitNumber ?? this.unitNumber,
      photos: photos ?? this.photos,
      document: document ?? this.document,
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
