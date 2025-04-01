import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/errors/api_error.dart';
import '../../core/network/api_client.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';
import '../models/auth/register_request.dart';
import '../models/auth/register_response.dart';

class AuthService {
  final Dio _dio;
  static const String _apiKey =
      'jEk40pLbflj4vQ6RyhQmI3JxDAXjUhdWrEjYBgQRAuSs8X6ged161peEtM4mM8sT';

  AuthService() : _dio = ApiClient.createDio();

  // Primer paso del login: enviar username y password
  Future<LoginResponse> loginStep1(String username, String password) async {
    try {
      final response = await _dio.post(
        '/api/Mobile/Login',
        data: LoginRequest(
          username: username,
          password: password,
        ).toJson(),
        options: Options(
          headers: {
            'X-API-KEY': _apiKey,
          },
        ),
      );

      // Si el código de respuesta es 202, significa que se requiere 2FA
      if (response.statusCode == 202) {
        return LoginResponse.fromJson({
          ...response.data,
          'requiresTwoFactor': true,
        });
      }

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // Segundo paso del login: enviar código 2FA
  Future<LoginResponse> loginStep2(String twoFactorCode) async {
    try {
      log('Entramos y se ejecuta loginStep2');
      log('Codigo 2FA: $twoFactorCode');

      final response = await _dio.post(
        '/api/Mobile/Login',
        data: LoginRequest(
          twoFactorCode: twoFactorCode,
        ).toJson(),
        options: Options(
          headers: {
            'X-API-KEY': _apiKey,
          },
        ),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<RegisterResponse> register(RegisterRequest request) async {
    try {
      final response = await _dio.post(
        '/api/Mobile/Register',
        data: request.toJson(),
        options: Options(
          headers: {
            'X-API-KEY': _apiKey,
          },
        ),
      );

      return RegisterResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
