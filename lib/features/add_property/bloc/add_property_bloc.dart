
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/features/add_property/bloc/add_property_event.dart';
import 'package:tobfolio/features/add_property/bloc/add_property_state.dart';
import 'package:tobfolio/features/add_property/utils/add_property_utils.dart';
import 'package:tobfolio/features/add_property/repositories/property_repository.dart';
import 'package:tobfolio/features/add_property/models/unit_model.dart';

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

    on<UpdateTotalUnits>((event, emit) {
      emit(state.copyWith(totalUnits: event.totalUnits));
    });

    on<AddUnit>((event, emit) {
      final updated = List<PropertyUnit>.from(state.units)..add(event.unit);
      emit(state.copyWith(units: updated));
    });

    on<UpdateUnit>((event, emit) {
      final updated = List<PropertyUnit>.from(state.units);
      if (event.index >= 0 && event.index < updated.length) {
        updated[event.index] = event.unit;
        emit(state.copyWith(units: updated));
      }
    });

    on<RemoveUnit>((event, emit) {
      final updated = List<PropertyUnit>.from(state.units)..removeAt(event.index);
      emit(state.copyWith(units: updated));
    });

    on<CreateProperty>(_onCreateProperty);
    on<CreateMultipleProperties>(_onCreateMultipleProperties);
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
        managementType: event.managementType,
        unitType: event.unitType,
        unitNumber: event.unitNumber,
        totalUnits: event.totalUnits,
        unitDescription: event.unitDescription,
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

  Future<void> _onCreateMultipleProperties(
    CreateMultipleProperties event,
    Emitter<AddPropertyState> emit,
  ) async {
    emit(state.copyWith(
      status: AddPropertyStatus.loading,
      clearError: true,
    ));

    try {
      // Create each unit as a separate property since endpoint doesn't support arrays
      for (int i = 0; i < event.units.length; i++) {
        final unit = event.units[i];
        final unitName = "${event.name} - Unit ${unit.unitNumber}";
        
        await _propertyRepository.createProperty(
          name: unitName,
          type: event.type,
          address: event.address,
          units: 1,
          propertyImages: unit.photos,
          managementType: 'entire_building',
          unitType: unit.unitType,
          unitNumber: unit.unitNumber.toString(),
          unitDescription: unit.description ?? '',
        );
      }

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