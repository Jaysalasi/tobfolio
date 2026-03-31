import 'package:equatable/equatable.dart';
import 'user.dart';

class LoginResponse extends Equatable {
  final String token;
  final User user;

  const LoginResponse({
    required this.token,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user.toJson(),
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginResponse &&
        other.token == token &&
        other.user == user;
  }

  @override
  int get hashCode {
    return token.hashCode ^ user.hashCode;
  }

  @override
  List<Object> get props => [token, user];
}
