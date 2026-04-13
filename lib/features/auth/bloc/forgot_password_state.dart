import 'dart:convert';

import 'package:equatable/equatable.dart';

enum ForgotPasswordStatus { initial, loading, success, failure }

class ForgotPasswordState extends Equatable {
  final ForgotPasswordStatus status;
  final ForgotPasswordResponse? forgotPasswordResponse;
  final String? errorMsg;

  const ForgotPasswordState({
    this.status = ForgotPasswordStatus.initial,
    this.forgotPasswordResponse,
     this.errorMsg,
  });

  ForgotPasswordState copyWith({
    ForgotPasswordStatus? status,
    ForgotPasswordResponse? forgotPasswordResponse,
    String? errorMsg,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      forgotPasswordResponse:
          forgotPasswordResponse ?? this.forgotPasswordResponse,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  @override
  List<Object?> get props => [status, forgotPasswordResponse, errorMsg];
}

class ForgotPasswordResponse {
  final String message;

  ForgotPasswordResponse({required this.message});

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponse(message: json["message"]);

  Map<String, dynamic> toJson() => {"message": message};
}
