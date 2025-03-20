// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      message: json['message'] as String,
      customerId: (json['customer_id'] as num).toInt(),
      customerName: json['customer_name'] as String,
      avatar: json['avatar'] as String?,
      languageCode: json['language_code'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'customer_id': instance.customerId,
      'customer_name': instance.customerName,
      'avatar': instance.avatar,
      'language_code': instance.languageCode,
    };
