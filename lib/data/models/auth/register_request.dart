import 'package:acceptance_app/data/constants.dart';

class RegisterRequest {
  String? brand;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final String password;
  final String birthDate;
  final String? policyNumber;

  RegisterRequest({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.birthDate,
    this.policyNumber,
    this.brand = brandConstant,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'Brand': brand,
      'FirstName': firstName,
      'LastName': lastName,
      'PhoneNumber': phoneNumber,
      'Email': email,
      'Password': password,
      'BirthDate': birthDate,
    };

    // Solo incluir el número de póliza si está presente
    if (policyNumber != null && policyNumber!.isNotEmpty) {
      data['PolicyNumber'] = policyNumber;
    }

    return data;
  }
}
