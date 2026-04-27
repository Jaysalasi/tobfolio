part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class LogoutRequested extends AuthEvent {}

class AuthUserUpdated extends AuthEvent {
  final User user;
  final bool isGoogleSignIn;

  const AuthUserUpdated(this.user, {this.isGoogleSignIn = false});

  @override
  List<Object> get props => [user, isGoogleSignIn];
}
