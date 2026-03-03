// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthPayload _$AuthPayloadFromJson(Map<String, dynamic> json) =>
    AuthPayload(payloadData: json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$AuthPayloadToJson(AuthPayload instance) =>
    <String, dynamic>{'data': instance.payloadData};

LoginPayload _$LoginPayloadFromJson(Map<String, dynamic> json) => LoginPayload(
  email: json['email'] as String,
  password: json['password'] as String,
  asRider: json['asRider'] as bool? ?? false,
  additionalData: json['additionalData'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$LoginPayloadToJson(LoginPayload instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'asRider': instance.asRider,
      'additionalData': instance.additionalData,
    };

RegisterPayload _$RegisterPayloadFromJson(Map<String, dynamic> json) =>
    RegisterPayload(
      name: json['name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['passwordConfirmation'] as String,
      asRider: json['asRider'] as bool? ?? false,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$RegisterPayloadToJson(RegisterPayload instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'passwordConfirmation': instance.passwordConfirmation,
      'asRider': instance.asRider,
      'additionalData': instance.additionalData,
    };
