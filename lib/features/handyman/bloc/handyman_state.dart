part of 'handyman_bloc.dart';

enum HandymanStatus { initial, loading, success, error }

class HandymanState extends Equatable {
  final HandymanStatus status;
  final List<Handyman> handymen;
  final String? errorMessage;
  final String? currentExpertise;
  final String? currentLocation;
  final String? currentSearch;

  const HandymanState({
    this.status = HandymanStatus.initial,
    this.handymen = const [],
    this.errorMessage,
    this.currentExpertise,
    this.currentLocation,
    this.currentSearch,
  });

  HandymanState copyWith({
    HandymanStatus? status,
    List<Handyman>? handymen,
    String? errorMessage,
    String? currentExpertise,
    String? currentLocation,
    String? currentSearch,
    bool clearError = false,
  }) {
    return HandymanState(
      status: status ?? this.status,
      handymen: handymen ?? this.handymen,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      currentExpertise: currentExpertise ?? this.currentExpertise,
      currentLocation: currentLocation ?? this.currentLocation,
      currentSearch: currentSearch ?? this.currentSearch,
    );
  }

  @override
  List<Object?> get props => [
        status,
        handymen,
        errorMessage,
        currentExpertise,
        currentLocation,
        currentSearch,
      ];

  @override
  String toString() {
    return 'HandymanState(status: $status, handymen: ${handymen.length}, errorMessage: $errorMessage)';
  }
}
