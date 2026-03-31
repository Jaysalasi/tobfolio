class RegisterRequest {
  final String name;
  final String email;
  final String password;
  // final String passwordConfirmation;

  const RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    // required this.passwordConfirmation,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      // passwordConfirmation: json['password_confirmation'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      // 'password_confirmation': passwordConfirmation,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RegisterRequest &&
        other.name == name &&
        other.email == email &&
        other.password == password;
        //  &&
        // other.passwordConfirmation == passwordConfirmation;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode;
    // // ^
    // // passwordConfirmation.hashCode;
  }

  @override
  String toString() => 'RegisterRequest(name: $name, email: $email, password: [hidden])';
}