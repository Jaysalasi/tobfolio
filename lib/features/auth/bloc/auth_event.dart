part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStarted extends AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  final bool asRider;

  const LoginRequested({
    required this.email,
    required this.password,
    required this.asRider,
  });

  @override
  List<Object> get props => [email, password, asRider];
}

class RegisterRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  List<Object> get props => [name, email, password, passwordConfirmation];
}

class LogoutRequested extends AuthEvent {}

class AuthUserUpdated extends AuthEvent {
  final User user;

  const AuthUserUpdated(this.user);

  @override
  List<Object> get props => [user];
}
