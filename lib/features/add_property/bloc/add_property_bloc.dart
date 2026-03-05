
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/add_property/bloc/add_property_event.dart';
import 'package:tob/features/add_property/bloc/add_property_state.dart';
import 'package:tob/features/add_property/utils/add_property_utils.dart';

class AddPropertyBloc extends Bloc<AddPropertyEvent, AddPropertyState> {
  AddPropertyBloc() : super(AddPropertyState()) {

    on<UpdateName>((event, emit) {
      emit(state.copyWith(name: event.name));
    });

    on<UpdateAddress>((event, emit) {
      emit(state.copyWith(address: event.address));
    });

    on<UpdatePropertyType>((event, emit) {
      emit(state.copyWith(propertyType: event.type));
    });

    on<AddPhoto>((event, emit) {
      final updated = List<PropertyPhoto>.from(state.photos)
        ..add(PropertyPhoto(event.path));

      emit(state.copyWith(photos: updated));
    });

    on<RemovePhoto>((event, emit) {
      final updated = List<PropertyPhoto>.from(state.photos)
        ..removeAt(event.index);

      emit(state.copyWith(photos: updated));
    });

  }
}