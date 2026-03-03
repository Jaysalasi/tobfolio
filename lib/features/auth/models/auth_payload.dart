 
part 'auth_payload.g.dart';
 
class AuthPayload { 
  final Map<String, dynamic> payloadData;

  const AuthPayload({
    required this.payloadData,
  });

  factory AuthPayload.fromJson(Map<String, dynamic> json) => _$AuthPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$AuthPayloadToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthPayload &&
        other.payloadData == payloadData;
  }

  @override
  int get hashCode => payloadData.hashCode;

  @override
  String toString() => 'AuthPayload(data: $payloadData)';
}
 
class LoginPayload {
  final String email;
  final String password;
  final bool asRider;
  final Map<String, dynamic>? additionalData;

  const LoginPayload({
    required this.email,
    required this.password,
    this.asRider = false,
    this.additionalData,
  });

  factory LoginPayload.fromJson(Map<String, dynamic> json) => _$LoginPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$LoginPayloadToJson(this);

  Map<String, dynamic> toApiData() {
    final baseData = {
      'email': email,
      'password': password,
      if (asRider) 'as_rider': true,
    };
     
    
    return baseData;
  }

  @override
  String toString() => 'LoginPayload(email: $email, as_rider: $asRider)';
}
 
class RegisterPayload {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;
  final bool asRider;
  final Map<String, dynamic>? additionalData;

  const RegisterPayload({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    this.asRider = false,
    this.additionalData,
  });

  factory RegisterPayload.fromJson(Map<String, dynamic> json) => _$RegisterPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterPayloadToJson(this);

  Map<String, dynamic> toApiData() {
    final baseData = {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      if (asRider) 'as_rider': true,
    };
    
     
    return baseData;
  }

  @override
  String toString() => 'RegisterPayload(email: $email, name: $name, as_rider: $asRider)';
}
