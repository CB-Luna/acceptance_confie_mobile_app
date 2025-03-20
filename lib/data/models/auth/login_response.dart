import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String message;

  @JsonKey(name: 'customer_id')
  final int customerId;

  @JsonKey(name: 'customer_name')
  final String customerName;

  /// URL de la imagen de avatar del usuario
  @JsonKey(name: 'avatar')
  final String? avatar;

  /// Código de idioma del usuario (ej: 'en_US', 'es_MX')
  @JsonKey(name: 'language_code')
  final String? languageCode;

  LoginResponse({
    required this.message,
    required this.customerId,
    required this.customerName,
    this.avatar,
    this.languageCode,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
