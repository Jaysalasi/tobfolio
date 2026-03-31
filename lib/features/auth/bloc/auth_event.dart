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

  const AuthUserUpdated(this.user);

  @override
  List<Object> get props => [user];
}
