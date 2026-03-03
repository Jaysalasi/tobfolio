class LoginRequest {
  final String email;
  final String password;
  final bool asRider;

  LoginRequest({
    required this.email,
    required this.password,
    this.asRider = false,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['login'] as String,
      password: json['password'] as String,
      asRider: json['as_rider'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': email,
      'password': password,
      if (asRider) 'as_rider': true,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginRequest &&
        other.email == email &&
        other.password == password &&
        other.asRider == asRider;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ asRider.hashCode;

  @override
  String toString() => 'LoginRequest(email: $email, password: [hidden], as_rider: $asRider)';
}