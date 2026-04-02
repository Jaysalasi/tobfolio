import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/handyman.dart';
import '../repositories/handyman_repository.dart';

part 'handyman_event.dart';
part 'handyman_state.dart';

class HandymanBloc extends Bloc<HandymanEvent, HandymanState> {
  final HandymanRepository _handymanRepository;

  HandymanBloc({required HandymanRepository handymanRepository})
      : _handymanRepository = handymanRepository,
        super(const HandymanState()) {
    on<GetHandymen>(_onGetHandymen);
    on<SearchHandymen>(_onSearchHandymen);
    on<FilterHandymen>(_onFilterHandymen);
    on<RefreshHandymen>(_onRefreshHandymen);
  }

  Future<void> _onGetHandymen(
    GetHandymen event,
    Emitter<HandymanState> emit,
  ) async {
    emit(state.copyWith(
      status: HandymanStatus.loading,
      clearError: true,
    ));

    try {
      final handymen = await _handymanRepository.getHandymen(
        expertise: event.expertise,
        location: event.location,
        search: event.search,
      );

      emit(state.copyWith(
        status: HandymanStatus.success,
        handymen: handymen,
        currentExpertise: event.expertise,
        currentLocation: event.location,
        currentSearch: event.search,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HandymanStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSearchHandymen(
    SearchHandymen event,
    Emitter<HandymanState> emit,
  ) async {
    emit(state.copyWith(
      status: HandymanStatus.loading,
      clearError: true,
    ));

    try {
      final handymen = await _handymanRepository.getHandymen(
        search: event.query,
        expertise: state.currentExpertise,
        location: state.currentLocation,
      );

      emit(state.copyWith(
        status: HandymanStatus.success,
        handymen: handymen,
        currentSearch: event.query,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HandymanStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onFilterHandymen(
    FilterHandymen event,
    Emitter<HandymanState> emit,
  ) async {
    emit(state.copyWith(
      status: HandymanStatus.loading,
      clearError: true,
    ));

    try {
      final handymen = await _handymanRepository.getHandymen(
        expertise: event.expertise,
        location: event.location,
        search: state.currentSearch,
      );

      emit(state.copyWith(
        status: HandymanStatus.success,
        handymen: handymen,
        currentExpertise: event.expertise,
        currentLocation: event.location,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HandymanStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshHandymen(
    RefreshHandymen event,
    Emitter<HandymanState> emit,
  ) async {
    emit(state.copyWith(
      status: HandymanStatus.loading,
      clearError: true,
    ));

    try {
      final handymen = await _handymanRepository.getHandymen(
        expertise: state.currentExpertise,
        location: state.currentLocation,
        search: state.currentSearch,
      );

      emit(state.copyWith(
        status: HandymanStatus.success,
        handymen: handymen,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HandymanStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
