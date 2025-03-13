// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_policy_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePolicyRequest _$HomePolicyRequestFromJson(Map<String, dynamic> json) =>
    HomePolicyRequest(
      customerId: (json['customer_id'] as num).toInt(),
    );

Map<String, dynamic> _$HomePolicyRequestToJson(HomePolicyRequest instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
    };
