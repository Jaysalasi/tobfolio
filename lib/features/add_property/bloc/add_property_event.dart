import 'package:tobfolio/features/add_property/models/unit_model.dart';

abstract class AddPropertyEvent {}

class UpdateName extends AddPropertyEvent {
  final String name;
  UpdateName(this.name);
}

class UpdateUnitNumber extends AddPropertyEvent {
  final int unitNumber;
  UpdateUnitNumber(this.unitNumber);
}

class UpdateDescription extends AddPropertyEvent {
  final String description;
  UpdateDescription(this.description);
}

class UpdateAddress extends AddPropertyEvent {
  final String address;
  UpdateAddress(this.address);
}

class UpdatePropertyType extends AddPropertyEvent {
  final String type;
  UpdatePropertyType(this.type);
}

class UpdateUnitType extends AddPropertyEvent {
  final String type;
  UpdateUnitType(this.type);
}

class AddPhoto extends AddPropertyEvent {
  final String path;
  AddPhoto(this.path);
}

class AddDocument extends AddPropertyEvent {
  final String path;
  AddDocument(this.path);
}

class RemovePhoto extends AddPropertyEvent {
  final int index;
  RemovePhoto(this.index);
}

class UpdateTotalUnits extends AddPropertyEvent {
  final int totalUnits;
  UpdateTotalUnits(this.totalUnits);
}

class CreateProperty extends AddPropertyEvent {
  final String name;
  final String type;
  final String address;
  final int units;
  final List<String> propertyImages;
  final String managementType;
  final String unitType;
  final String unitNumber;
  final int totalUnits;
  final String unitDescription;

  CreateProperty({
    required this.name,
    required this.type,
    required this.address,
    required this.units,
    required this.propertyImages,
    required this.managementType,
    this.unitType = '',
    this.unitNumber = '',
    this.totalUnits = 0,
    this.unitDescription = '',
  });
}

// Multi-unit events
class AddUnit extends AddPropertyEvent {
  final PropertyUnit unit;
  AddUnit(this.unit);
}

class UpdateUnit extends AddPropertyEvent {
  final int index;
  final PropertyUnit unit;
  UpdateUnit(this.index, this.unit);
}

class RemoveUnit extends AddPropertyEvent {
  final int index;
  RemoveUnit(this.index);
}

class CreateMultipleProperties extends AddPropertyEvent {
  final String name;
  final String type;
  final String address;
  final List<String> propertyImages;
  final List<PropertyUnit> units;

  CreateMultipleProperties({
    required this.name,
    required this.type,
    required this.address,
    required this.propertyImages,
    required this.units,
  });
}