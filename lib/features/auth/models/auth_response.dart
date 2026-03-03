import 'package:tob/features/auth/models/user.dart';

class AuthResponse {
  final String status;
  final String message;
  final AuthData data;
  final String timestamp;

  const AuthResponse({
    required this.status,
    required this.message,
    required this.data,
    required this.timestamp,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: AuthData.fromJson(json['data'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
      'timestamp': timestamp,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthResponse &&
        other.status == status &&
        other.message == message &&
        other.data == data &&
        other.timestamp == timestamp;
  }

  @override
  int get hashCode {
    return status.hashCode ^
        message.hashCode ^
        data.hashCode ^
        timestamp.hashCode;
  }

  @override
  String toString() => 'AuthResponse(status: $status, message: $message)';
}

class AuthData {
  final String accessToken;
  final String tokenType;
  final User user;

  const AuthData({
    required this.accessToken,
    required this.tokenType,
    required this.user,
  });

  factory AuthData.fromJson(Map<String, dynamic> json) {
    return AuthData(
      accessToken: json['access_token'] as String,
      tokenType: json['token_type'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'user': user.toJson(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthData &&
        other.accessToken == accessToken &&
        other.tokenType == tokenType &&
        other.user == user;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^
        tokenType.hashCode ^
        user.hashCode;
  }

  @override
  String toString() => 'AuthData(tokenType: $tokenType, user: ${user.fname})';
}