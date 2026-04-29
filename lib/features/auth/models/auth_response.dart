import 'package:tobfolio/features/auth/models/user.dart';

class AuthResponse {
  final String referralCode;
  final String message;

  const AuthResponse({
    required this.referralCode,
    required this.message,
   
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      
      message: json['message'] as String,
      referralCode: json['referralCode'] as String,
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      
      'message': message,
      'referralCode': referralCode,
     
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthResponse &&
        other.referralCode == referralCode &&
        other.message == message;
  }

  @override
  int get hashCode {
    return  referralCode.hashCode ^
        message.hashCode;
  }

  @override
  String toString() => 'AuthResponse(referralCode: $referralCode, message: $message)';
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
  String toString() => 'AuthData(tokenType: $tokenType, user: ${user.name})';
}