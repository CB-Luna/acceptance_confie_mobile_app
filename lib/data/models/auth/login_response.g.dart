// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      token: json['token'] as String?,
      requiresTwoFactor: json['requiresTwoFactor'] as bool? ?? false,
      errors: (json['errors'] as List<dynamic>?)
              ?.map((e) => ErrorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'requiresTwoFactor': instance.requiresTwoFactor,
      'errors': instance.errors,
    };
