import 'package:equatable/equatable.dart';

abstract class AllPropertyEvent extends Equatable {
  const AllPropertyEvent();

  @override
  List<Object?> get props => [];
}

class LoadProperties extends AllPropertyEvent {}

class DeleteProperty extends AllPropertyEvent {
  final String propertyId;

  const DeleteProperty(this.propertyId);

  @override
  List<Object?> get props => [propertyId];
}

class UpdateProperty extends AllPropertyEvent {
  final String propertyId;
  final Map<String, dynamic> fields;

  const UpdateProperty({required this.propertyId, required this.fields});

  @override
  List<Object?> get props => [propertyId, fields];
}