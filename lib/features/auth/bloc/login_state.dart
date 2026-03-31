part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, failure }

class LoginState extends Equatable {
  final LoginStatus status;
  final LoginResponse? loginResponse;
  final String? errorMessage;

  const LoginState({
    this.status = LoginStatus.initial,
    this.loginResponse,
    this.errorMessage,
  });

  LoginState copyWith({
    LoginStatus? status,
    LoginResponse? loginResponse,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      loginResponse: loginResponse ?? this.loginResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, loginResponse, errorMessage];

  @override
  String toString() => 'LoginState(status: $status, errorMessage: $errorMessage)';
}
