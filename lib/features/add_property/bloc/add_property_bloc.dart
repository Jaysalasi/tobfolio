
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/add_property/bloc/add_property_event.dart';
import 'package:tob/features/add_property/bloc/add_property_state.dart';
import 'package:tob/features/add_property/utils/add_property_utils.dart';
import 'package:tob/features/add_property/repositories/property_repository.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  final PropertyRepository _propertyRepository;

  AddPropertyBloc({required PropertyRepository propertyRepository})
      : _propertyRepository = propertyRepository,
        super(AddPropertyState()) {

    on<UpdateName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<UpdateUnitNumber>((event, emit) {
      emit(state.copyWith(unitNumber: event.unitNumber));
    });

    on<UpdateDescription>((event, emit) {
      emit(state.copyWith(description: event.description));
    });

    on<UpdateAddress>((event, emit) {
      emit(state.copyWith(address: event.address));
    });

    on<UpdatePropertyType>((event, emit) {
      emit(state.copyWith(propertyType: event.type));
    });

    on<UpdateUnitType>((event, emit) {
      emit(state.copyWith(unitType: event.type));
    });

    on<AddPhoto>((event, emit) {
      final updated = List<PropertyPhoto>.from(state.photos)
        ..add(PropertyPhoto(event.path));

      emit(state.copyWith(photos: updated));
    });
  
    on<AddDocument>((event, emit) {
      emit(state.copyWith(document: event.path));
    });

    on<RemovePhoto>((event, emit) {
      final updated = List<PropertyPhoto>.from(state.photos)
        ..removeAt(event.index);

      emit(state.copyWith(photos: updated));
    });

    on<CreateProperty>(_onCreateProperty);
  }

  Future<void> _onCreateProperty(
    CreateProperty event,
    Emitter<AddPropertyState> emit,
  ) async {
    emit(state.copyWith(
      status: AddPropertyStatus.loading,
      clearError: true,
    ));

    try {
      await _propertyRepository.createProperty(
        name: event.name,
        type: event.type,
        address: event.address,
        units: event.units,
        propertyImages: event.propertyImages,
      );

      emit(state.copyWith(
        status: AddPropertyStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: AddPropertyStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}