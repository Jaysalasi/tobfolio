// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flexible_auth_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlexibleAuthPayload _$FlexibleAuthPayloadFromJson(Map<String, dynamic> json) =>
    FlexibleAuthPayload(
      email: json['email'] as String,
      password: json['password'] as String,
      asRider: json['asRider'] as bool? ?? false,
      name: json['name'] as String?,
      passwordConfirmation: json['passwordConfirmation'] as String?,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$FlexibleAuthPayloadToJson(
  FlexibleAuthPayload instance,
) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
  'asRider': instance.asRider,
  'name': instance.name,
  'passwordConfirmation': instance.passwordConfirmation,
  'additionalData': instance.additionalData,
};
