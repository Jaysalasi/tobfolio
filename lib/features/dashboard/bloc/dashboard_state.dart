part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {
  final bool isLoading;
  final String? errorMessage;

  const DashboardState({
    this.isLoading = false,
    this.errorMessage,
  });

  DashboardState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage];

  @override
  String toString() => 'DashboardState(isLoading: $isLoading, errorMessage: $errorMessage)';
}
