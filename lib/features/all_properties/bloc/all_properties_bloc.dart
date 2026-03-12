import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tob/features/all_properties/bloc/all_properties_event.dart';
import 'package:tob/features/all_properties/bloc/all_properties_state.dart';
import 'package:tob/features/all_properties/model/all_property_model.dart';

class AllPropertyBloc extends Bloc<AllPropertyEvent, AllPropertyState> {
  AllPropertyBloc() : super(PropertyInitial()) {
    on<LoadProperties>(_load);
  }

  Future<void> _load(
    LoadProperties event,
    Emitter<AllPropertyState> emit,
  ) async {
    emit(PropertyLoading());

    await Future.delayed(const Duration(milliseconds: 500));

    final properties = [
      PropertyModel(
        id: "1",
        name: "Lekki House",
        address: "No. 13 Ben Carson. Ikoyi, Lagos",
        type: "Residential",
        income: 20000000,
        expenses: 3000000,
        images: [
          "assets/images/house.png",
          "assets/images/house.png",
          "assets/images/house.png",
        ],
      ),
    ];

    emit(PropertyLoaded(properties));
  }
}