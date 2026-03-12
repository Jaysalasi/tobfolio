import 'package:equatable/equatable.dart';
import 'package:tob/features/all_properties/model/all_property_model.dart';

abstract class AllPropertyState extends Equatable {
  const AllPropertyState();

  @override
  List<Object?> get props => [];
}

class PropertyInitial extends AllPropertyState {}

class PropertyLoading extends AllPropertyState {}

class PropertyLoaded extends AllPropertyState {
  final List<PropertyModel> properties;

  const PropertyLoaded(this.properties);

  @override
  List<Object?> get props => [properties];
}

class PropertyError extends AllPropertyState {
  final String message;

  const PropertyError(this.message);

  @override
  List<Object?> get props => [message];
}