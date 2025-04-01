import 'dart:convert';

class LoginRequest {
  final String? username;
  final String? password;
  final String? twoFactorCode;

  LoginRequest({
    this.username,
    this.password,
    this.twoFactorCode,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (username != null) data['username'] = username;
    if (password != null) data['password'] = password;
    if (twoFactorCode != null) data['twoFactorCode'] = twoFactorCode;

    return data;
  }

  String toJsonString() => json.encode(toJson());
}
