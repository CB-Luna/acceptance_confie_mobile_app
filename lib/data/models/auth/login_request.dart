import 'dart:convert';

import 'package:acceptance_app/data/constants.dart';

class LoginRequest {
  final String brand;
  final String? username;
  final String? password;
  final String? twoFactorCode;
  final bool? trustedDevice;

  LoginRequest({
    this.brand = brandConstant,
    this.username,
    this.password,
    this.twoFactorCode,
    this.trustedDevice,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};

    data['Brand'] = brand;
    if (username != null) data['Username'] = username;
    if (password != null) data['Password'] = password;
    if (twoFactorCode != null) data['TwoFactorCode'] = twoFactorCode;
    if (trustedDevice != null) data['TrustedDevice'] = trustedDevice;

    return data;
  }

  String toJsonString() => json.encode(toJson());
}
