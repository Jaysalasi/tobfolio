 
part 'flexible_auth_payload.g.dart';
 
class FlexibleAuthPayload {
  final String email;
  final String password;
  final bool asRider;
  final String? name;
  final String? passwordConfirmation;
  final Map<String, dynamic>? additionalData;

  const FlexibleAuthPayload({
    required this.email,
    required this.password,
    this.asRider = false,
    this.name,
    this.passwordConfirmation,
    this.additionalData,
  });

  factory FlexibleAuthPayload.fromJson(Map<String, dynamic> json) => _$FlexibleAuthPayloadFromJson(json);
  Map<String, dynamic> toJson() => _$FlexibleAuthPayloadToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FlexibleAuthPayload &&
        other.email == email &&
        other.password == password &&
        other.asRider == asRider &&
        other.name == name &&
        other.passwordConfirmation == passwordConfirmation;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ asRider.hashCode ^ name.hashCode ^ passwordConfirmation.hashCode;

  @override
  String toString() => 'FlexibleAuthPayload(email: $email, name: $name, as_rider: $asRider)';

  // Factory methods for specific auth types
  factory FlexibleAuthPayload.login({
    required String email,
    required String password,
    bool asRider = false,
    Map<String, dynamic>? additionalData,
  }) {
    return FlexibleAuthPayload(
      email: email,
      password: password,
      asRider: asRider,
      additionalData: additionalData,
    );
  }

  factory FlexibleAuthPayload.register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
    bool asRider = false,
    Map<String, dynamic>? additionalData,
  }) {
    return FlexibleAuthPayload(
      email: email,
      password: password,
      asRider: asRider,
      name: name,
      passwordConfirmation: passwordConfirmation,
      additionalData: additionalData,
    );
  }

  // Convert to API request data
  Map<String, Object> toApiData() {
    final data = <String, Object>{
      'email': email,
      'password': password,
      if (asRider) 'as_rider': true,
    };

    // Add name for registration
    if (name != null) {
      data['name'] = name!;
    }

    // Add password confirmation for registration
    if (passwordConfirmation != null) {
      data['password_confirmation'] = passwordConfirmation!;
    }

    // Add any additional data
    if (additionalData != null) {
      
    }

    return data;
  }
}
