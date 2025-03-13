import 'package:dio/dio.dart';
import '../../core/errors/api_error.dart';
import '../../core/network/api_client.dart';
import '../models/auth/login_request.dart';
import '../models/auth/login_response.dart';

class AuthService {
  final Dio _dio;

  AuthService() : _dio = ApiClient.createDio();

  Future<LoginResponse> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/webhook/confie_auth',
        data: LoginRequest(
          userName: username,
          password: password,
        ).toJson(),
      );

      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiError.fromDioError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
