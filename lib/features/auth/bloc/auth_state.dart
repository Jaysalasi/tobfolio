part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;
  final String? errorMessage;
  final bool isGoogleSignIn;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.errorMessage,
    this.isGoogleSignIn = false,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? errorMessage,
    bool? isGoogleSignIn,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      isGoogleSignIn: isGoogleSignIn ?? this.isGoogleSignIn,
    );
  }

  @override
  List<Object?> get props => [status, user, errorMessage, isGoogleSignIn];

  @override
  String toString() => 'AuthState(status: $status, user: $user, isGoogleSignIn: $isGoogleSignIn, errorMessage: $errorMessage)';
}
