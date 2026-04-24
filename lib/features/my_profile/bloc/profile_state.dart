part of 'profile_bloc.dart';

enum ProfileStatus { initial, loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final String? errorMessage;

  const ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProfileState(
      status: status ?? this.status,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [status, errorMessage];
}
