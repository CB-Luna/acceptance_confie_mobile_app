import 'package:json_annotation/json_annotation.dart';
import 'error_model.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final String? token;
  final bool requiresTwoFactor;
  final List<ErrorModel> errors;

  LoginResponse({
    this.token,
    this.requiresTwoFactor = false,
    this.errors = const [],
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    List<ErrorModel> errorsList = [];
    if (json['errors'] != null) {
      if (json['errors'] is List) {
        errorsList = (json['errors'] as List)
            .map((e) => ErrorModel.fromJson(e))
            .toList();
      }
    }

    return LoginResponse(
      token: json['token'],
      requiresTwoFactor: json['requiresTwoFactor'] ?? false,
      errors: errorsList,
    );
  }

  bool get hasErrors => errors.isNotEmpty;

  String get errorMessage {
    if (!hasErrors) return '';
    return errors.map((e) => '${e.field}: ${e.message}').join(', ');
  }

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
