class LoginRequest {
  final String email;
  final String password; 

  LoginRequest({
    required this.email,
    required this.password, 
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(
      email: json['login'] as String,
      password: json['password'] as String,
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is LoginRequest &&
        other.email == email &&
        other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  String toString() => 'LoginRequest(email: $email, password: [hidden])';
}