// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      vehicleId: (json['vehicle_id'] as num).toInt(),
      plate: json['plate'] as String,
      brand: json['brand'] as String,
      model: json['model'] as String,
      vehicleTypeId: (json['vehicle_type_id'] as num?)?.toInt(),
      vehicleType: json['vehicle_type'] as String?,
      providerId: (json['provider_id'] as num).toInt(),
      providerImage: json['provider_image'] as String,
      policyTypeId: (json['policy_type_id'] as num).toInt(),
      policyType: json['policy_type'] as String,
      transactionType: json['transaction_type'] as String?,
      memberSince: json['member_since'] as String?,
      serviceId: (json['service_id'] as num?)?.toInt(),
      serviceName: json['name'] as String?,
      nextPaymentDate: json['next_payment_date'] as String,
      customerId: (json['customer_id'] as num).toInt(),
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      'vehicle_id': instance.vehicleId,
      'plate': instance.plate,
      'brand': instance.brand,
      'model': instance.model,
      'vehicle_type_id': instance.vehicleTypeId,
      'vehicle_type': instance.vehicleType,
      'provider_id': instance.providerId,
      'provider_image': instance.providerImage,
      'policy_type_id': instance.policyTypeId,
      'policy_type': instance.policyType,
      'transaction_type': instance.transactionType,
      'member_since': instance.memberSince,
      'service_id': instance.serviceId,
      'name': instance.serviceName,
      'next_payment_date': instance.nextPaymentDate,
      'customer_id': instance.customerId,
    };
