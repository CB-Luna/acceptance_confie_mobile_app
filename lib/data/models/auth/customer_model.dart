import 'package:json_annotation/json_annotation.dart';

part 'customer_model.g.dart';

@JsonSerializable()
class CustomerModel {
  final String customerId;
  final String organizationName;
  final String organizationCode;
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String birthDate;
  final String gender;
  final String verbalLanguage;
  final String documentLanguage;
  final String email;
  final PhoneModel primaryPhone;
  final AddressModel primaryAddress;

  CustomerModel({
    required this.customerId,
    required this.organizationName,
    required this.organizationCode,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.fullName,
    required this.birthDate,
    required this.gender,
    required this.verbalLanguage,
    required this.documentLanguage,
    required this.email,
    required this.primaryPhone,
    required this.primaryAddress,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => _$CustomerModelFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerModelToJson(this);
}

@JsonSerializable()
class PhoneModel {
  final String phoneType;
  final String phoneNumber;

  PhoneModel({
    required this.phoneType,
    required this.phoneNumber,
  });

  factory PhoneModel.fromJson(Map<String, dynamic> json) => _$PhoneModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhoneModelToJson(this);
}

@JsonSerializable()
class AddressModel {
  final String addressType;
  final String street;
  final String city;
  final String state;
  final String zip;
  final String zip4;

  AddressModel({
    required this.addressType,
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.zip4,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
