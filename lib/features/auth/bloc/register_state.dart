part of 'register_bloc.dart';

enum RegisterStatus { initial, loading, success, failure }

class RegisterState extends Equatable {
  final RegisterStatus status;
  final AuthResponse? authResponse;
  final String? errorMessage;
  final bool isGoogleSignIn;

  const RegisterState({
    this.status = RegisterStatus.initial,
    this.authResponse,
    this.errorMessage,
    this.isGoogleSignIn = false,
  });

  RegisterState copyWith({
    RegisterStatus? status,
    AuthResponse? authResponse,
    String? errorMessage,
    bool? isGoogleSignIn,
  }) {
    return RegisterState(
      status: status ?? this.status,
      authResponse: authResponse ?? this.authResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      isGoogleSignIn: isGoogleSignIn ?? this.isGoogleSignIn,
    );
  }

  @override
  List<Object?> get props => [status, authResponse, errorMessage, isGoogleSignIn];

  @override
  String toString() => 'RegisterState(status: $status, errorMessage: $errorMessage)';
}
