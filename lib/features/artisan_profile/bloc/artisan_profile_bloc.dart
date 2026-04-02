import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../handyman/models/handyman.dart';
import '../../handyman/repositories/handyman_repository.dart';

part 'artisan_profile_event.dart';
part 'artisan_profile_state.dart';

class ArtisanProfileBloc extends Bloc<ArtisanProfileEvent, ArtisanProfileState> {
  final HandymanRepository _handymanRepository;
  String? _currentId;

  ArtisanProfileBloc({required HandymanRepository handymanRepository})
      : _handymanRepository = handymanRepository,
        super(const ArtisanProfileState()) {
    on<GetArtisanProfile>(_onGetArtisanProfile);
    on<RefreshArtisanProfile>(_onRefreshArtisanProfile);
  }

  Future<void> _onGetArtisanProfile(
    GetArtisanProfile event,
    Emitter<ArtisanProfileState> emit,
  ) async {
    _currentId = event.id;
    emit(state.copyWith(
      status: ArtisanProfileStatus.loading,
      clearError: true,
    ));

    try {
      final response = await _handymanRepository.getHandymanById(event.id);
      final handymanData = response['handyman'] as Map<String, dynamic>;
      final reviewsData = response['reviews'] as List<dynamic>;
      
      final handyman = Handyman.fromJson(handymanData);
      
      emit(state.copyWith(
        status: ArtisanProfileStatus.success,
        handyman: handyman,
        reviews: reviewsData,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArtisanProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshArtisanProfile(
    RefreshArtisanProfile event,
    Emitter<ArtisanProfileState> emit,
  ) async {
    if (_currentId == null) return;

    emit(state.copyWith(
      status: ArtisanProfileStatus.loading,
      clearError: true,
    ));

    try {
      final response = await _handymanRepository.getHandymanById(_currentId!);
      final handymanData = response['handyman'] as Map<String, dynamic>;
      final reviewsData = response['reviews'] as List<dynamic>;
      
      final handyman = Handyman.fromJson(handymanData);
      
      emit(state.copyWith(
        status: ArtisanProfileStatus.success,
        handyman: handyman,
        reviews: reviewsData,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArtisanProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
