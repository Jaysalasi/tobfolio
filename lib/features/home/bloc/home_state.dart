part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final User? user;
  final DashboardModel? dashboard;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
    this.dashboard,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    User? user,
    DashboardModel? dashboard,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      dashboard: dashboard ?? this.dashboard,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, user, dashboard];

  @override
  String toString() => 'HomeState(isLoading: $isLoading, errorMessage: $errorMessage, user: $user, dashboard: $dashboard)';
}
