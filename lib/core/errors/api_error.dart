class ApiError implements Exception {
  final String message;
  final int? statusCode;
  final dynamic error;

  ApiError({
    required this.message,
    this.statusCode,
    this.error,
  });

  factory ApiError.fromDioError(dynamic error) {
    String message = 'Error desconocido';
    int? statusCode;

    if (error.response != null) {
      statusCode = error.response?.statusCode;
      message = error.response?.statusMessage ?? message;
    } else if (error.error != null) {
      message = error.error.toString();
    } else {
      message = error.message ?? message;
    }

    return ApiError(
      message: message,
      statusCode: statusCode,
      error: error,
    );
  }

  @override
  String toString() => 'ApiError: $message';
}
