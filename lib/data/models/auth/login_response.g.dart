// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String?,
      customer: json['customer'] == null
          ? null
          : CustomerModel.fromJson(json['customer'] as Map<String, dynamic>),
      policies: (json['policies'] as List<dynamic>?)
              ?.map((e) => PolicyModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      requiresTwoFactor: json['requiresTwoFactor'] as bool? ?? false,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => ErrorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'customer': instance.customer,
      'policies': instance.policies,
      'requiresTwoFactor': instance.requiresTwoFactor,
      'errors': instance.errors,
    };
