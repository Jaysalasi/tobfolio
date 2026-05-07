import 'package:tobfolio/features/add_property/utils/add_property_utils.dart';
import 'package:tobfolio/features/add_property/models/unit_model.dart';

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
  final int? totalUnits;
  final List<PropertyPhoto> photos;
  final String document;
  final List<PropertyUnit> units;
  final AddPropertyStatus status;
  final String? errorMessage;

  AddPropertyState({
    this.name = '',
    this.address = '',
    this.propertyType = '',
    this.unitType = '',
    this.description,
    this.unitNumber,
    this.totalUnits,
    this.photos = const [],
    this.document = '',
    this.units = const [],
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
    int? totalUnits,
    List<PropertyPhoto>? photos,
    String? document,
    List<PropertyUnit>? units,
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
      totalUnits: totalUnits ?? this.totalUnits,
      photos: photos ?? this.photos,
      document: document ?? this.document,
      units: units ?? this.units,
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
