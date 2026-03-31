part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final User? user;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    User? user,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, user];

  @override
  String toString() => 'HomeState(isLoading: $isLoading, errorMessage: $errorMessage, user: $user)';
}
