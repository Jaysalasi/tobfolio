part of 'artisan_profile_bloc.dart';

enum ArtisanProfileStatus { initial, loading, success, error, creatingReview, reviewCreated }

class ArtisanProfileState extends Equatable {
  final ArtisanProfileStatus status;
  final Handyman? handyman;
  final List<Review> reviews;
  final String? errorMessage;

  const ArtisanProfileState({
    this.status = ArtisanProfileStatus.initial,
    this.handyman,
    this.reviews = const [],
    this.errorMessage,
  });

  ArtisanProfileState copyWith({
    ArtisanProfileStatus? status,
    Handyman? handyman,
    List<Review>? reviews,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ArtisanProfileState(
      status: status ?? this.status,
      handyman: handyman ?? this.handyman,
      reviews: reviews ?? this.reviews,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, handyman, reviews, errorMessage];

  @override
  String toString() {
    return 'ArtisanProfileState(status: $status, handyman: ${handyman?.fullName}, reviews: ${reviews.length}, errorMessage: $errorMessage)';
  }
}
