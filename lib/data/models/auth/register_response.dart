class RegisterResponse {
  final bool emailConfirmationSent;
  final bool phoneConfirmationSent;
  final List<RegisterError> errors;

  RegisterResponse({
    required this.emailConfirmationSent,
    required this.phoneConfirmationSent,
    required this.errors,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    List<RegisterError> errorsList = [];
    if (json['errors'] != null) {
      errorsList = List<RegisterError>.from(
        (json['errors'] as List).map((e) => RegisterError.fromJson(e)),
      );
    }

    return RegisterResponse(
      emailConfirmationSent: json['emailConfirmationSent'] ?? false,
      phoneConfirmationSent: json['phoneConfirmationSent'] ?? false,
      errors: errorsList,
    );
  }

  bool get hasErrors => errors.isNotEmpty;
  
  String get errorMessage {
    if (errors.isEmpty) return '';
    return errors.map((e) => '${e.field}: ${e.message}').join(', ');
  }
}

class RegisterError {
  final String field;
  final String message;

  RegisterError({
    required this.field,
    required this.message,
  });

  factory RegisterError.fromJson(Map<String, dynamic> json) {
    return RegisterError(
      field: json['field'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
