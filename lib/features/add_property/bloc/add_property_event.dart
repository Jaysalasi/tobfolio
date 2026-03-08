abstract class AddPropertyEvent {}

class UpdateName extends AddPropertyEvent {
  final String name;
  UpdateName(this.name);
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