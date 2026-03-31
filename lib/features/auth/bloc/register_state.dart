part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final AuthResponse? authResponse;
  final String? errorMessage;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.authResponse,
    this.errorMessage,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    AuthResponse? authResponse,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      authResponse: authResponse ?? this.authResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, authResponse, errorMessage];

  @override
  String toString() => 'RegisterState(status: $status, errorMessage: $errorMessage)';
}
