import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request.g.dart';

@JsonSerializable()
class SendForgotPasswordRequest {
  final String userName;
  final String verificationType; // "SmsCode" o "EmailCode"

  SendForgotPasswordRequest({
    required this.userName,
    required this.verificationType,
  });

  factory SendForgotPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$SendForgotPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendForgotPasswordRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordRequest {
  final String userName;
  final String code;
  final String newPassword;

  ResetPasswordRequest({
    required this.userName,
    required this.code,
    required this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
