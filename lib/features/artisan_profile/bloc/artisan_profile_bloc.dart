import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../handyman/models/handyman.dart';
import '../../handyman/repositories/handyman_repository.dart';
import '../models/review.dart';
import '../../auth/repositories/auth_repository.dart';

part 'artisan_profile_event.dart';
part 'artisan_profile_state.dart';

class ArtisanProfileBloc extends Bloc<ArtisanProfileEvent, ArtisanProfileState> {
  final HandymanRepository _handymanRepository;
  final AuthRepository _authRepository;
  String? _currentId;

  ArtisanProfileBloc({
    required HandymanRepository handymanRepository,
    required AuthRepository authRepository,
  }) : _handymanRepository = handymanRepository,
       _authRepository = authRepository,
       super(const ArtisanProfileState()) {
    on<GetArtisanProfile>(_onGetArtisanProfile);
    on<RefreshArtisanProfile>(_onRefreshArtisanProfile);
    on<CreateReview>(_onCreateReview);
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
      final reviews = reviewsData
          .map((review) => Review.fromJson(review as Map<String, dynamic>))
          .cast<Review>()
          .toList();
      
      emit(state.copyWith(
        status: ArtisanProfileStatus.success,
        handyman: handyman,
        reviews: reviews,
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
      final reviews = reviewsData
          .map((review) => Review.fromJson(review as Map<String, dynamic>))
          .cast<Review>()
          .toList();
      
      emit(state.copyWith(
        status: ArtisanProfileStatus.success,
        handyman: handyman,
        reviews: reviews,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ArtisanProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onCreateReview(
    CreateReview event,
    Emitter<ArtisanProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: ArtisanProfileStatus.creatingReview,
      clearError: true,
    ));

    try {
      final reviewData = {
        'rating': event.rating,
        'comment': event.comment,
      };

      await _handymanRepository.createReview(event.handymanId, reviewData);
      
      emit(state.copyWith(
        status: ArtisanProfileStatus.reviewCreated,
      ));

      // Refresh the profile to get updated reviews
      add(RefreshArtisanProfile());
    } catch (e) {
      // Check if it's an auth error and handle automatically
      if (e.toString().toLowerCase().contains('authorization') ||
          e.toString().toLowerCase().contains('token') ||
          e.toString().toLowerCase().contains('unauthorized')) {
        await _authRepository.logout();
      }
      
      emit(state.copyWith(
        status: ArtisanProfileStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
