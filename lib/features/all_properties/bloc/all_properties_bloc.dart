import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_event.dart';
import 'package:tobfolio/features/all_properties/bloc/all_properties_state.dart';
import 'package:tobfolio/features/all_properties/repositories/all_properties_repository.dart';

class AllPropertyBloc extends Bloc<AllPropertyEvent, AllPropertyState> {
  final AllPropertiesRepository _repository;

  AllPropertyBloc({required AllPropertiesRepository repository})
      : _repository = repository,
        super(PropertyInitial()) {
    on<LoadProperties>(_load);
    on<DeleteProperty>(_delete);
    on<UpdateProperty>(_update);
  }

  Future<void> _load(
    LoadProperties event,
    Emitter<AllPropertyState> emit,
  ) async {
    emit(PropertyLoading());
    
    try {
      final propertiesData = await _repository.getAllProperties();
      final properties = propertiesData;
      emit(PropertyLoaded(properties));
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> _delete(
    DeleteProperty event,
    Emitter<AllPropertyState> emit,
  ) async {
    emit(PropertyDeleting());

    try {
      await _repository.deleteProperty(event.propertyId);
      emit(PropertyDeleteSuccess());
      add(LoadProperties());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }

  Future<void> _update(
    UpdateProperty event,
    Emitter<AllPropertyState> emit,
  ) async {
    emit(PropertyUpdating());

    try {
      await _repository.updateProperty(event.propertyId, event.fields);
      emit(PropertyUpdateSuccess());
      add(LoadProperties());
    } catch (e) {
      emit(PropertyError(e.toString()));
    }
  }
}