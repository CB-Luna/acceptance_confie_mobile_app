import 'package:json_annotation/json_annotation.dart';

part 'error_model.g.dart';

@JsonSerializable()
class ErrorModel {
  final String field;
  final String message;
  final String? code;

  ErrorModel({
    required this.field,
    required this.message,
    this.code,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      field: json['field'] ?? '',
      message: json['message'] ?? 'Unknown error',
      code: json['code'],
    );
  }
}
