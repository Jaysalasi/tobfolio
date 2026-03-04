part of 'home_bloc.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage];

  @override
  String toString() => 'HomeState(isLoading: $isLoading, errorMessage: $errorMessage)';
}
