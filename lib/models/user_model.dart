import 'package:freeway_app/data/models/auth/customer_model.dart';
import 'package:freeway_app/data/models/auth/policy_model.dart';

class User {
  final String username;
  final String fullName;
  final String policyNumber;
  final String? policyUsaState;
  final DateTime nextPayment;
  final String policyType;
  final int customerId; // Añadido para poder hacer la llamada a la API
  final String? email; // Añadido para información de contacto
  final String? phone; // Añadido para información de contacto
  final String? avatar; // URL de la imagen de avatar del usuario
  final DateTime birthDate;
  final String?
      languageCode; // Código de idioma del usuario (ej: 'en_US', 'es_MX')
  final String street;
  final String zipCode;
  final String city;
  final String state;
  final String? carrierName;

  // Nuevos campos para almacenar la información completa del customer y policies
  final CustomerModel? customerData;
  final List<PolicyModel> policies;

  User({
    required this.username,
    required this.fullName,
    required this.policyNumber,
    required this.nextPayment,
    required this.policyType,
    required this.customerId,
    required this.street,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.birthDate,
    this.policyUsaState,
    this.email,
    this.phone,
    this.avatar,
    this.languageCode,
    this.carrierName,
    this.customerData,
    this.policies = const [],
  });

  // Método para obtener la póliza activa (la primera por defecto)
  PolicyModel? get activePolicy => policies.isNotEmpty ? policies.first : null;

  // Método para verificar si el usuario tiene pólizas
  bool get hasPolicies => policies.isNotEmpty;

  // Método para obtener el número de pólizas
  int get policyCount => policies.length;
  
  // Método para crear una copia del usuario con algunos campos actualizados
  User copyWith({
    String? username,
    String? fullName,
    String? policyNumber,
    String? policyUsaState,
    DateTime? nextPayment,
    String? policyType,
    int? customerId,
    String? email,
    String? phone,
    String? avatar,
    DateTime? birthDate,
    String? languageCode,
    String? street,
    String? zipCode,
    String? city,
    String? state,
    String? carrierName,
    CustomerModel? customerData,
    List<PolicyModel>? policies,
  }) {
    return User(
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      policyNumber: policyNumber ?? this.policyNumber,
      policyUsaState: policyUsaState ?? this.policyUsaState,
      nextPayment: nextPayment ?? this.nextPayment,
      policyType: policyType ?? this.policyType,
      customerId: customerId ?? this.customerId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      birthDate: birthDate ?? this.birthDate,
      languageCode: languageCode ?? this.languageCode,
      street: street ?? this.street,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      state: state ?? this.state,
      carrierName: carrierName ?? this.carrierName,
      customerData: customerData ?? this.customerData,
      policies: policies ?? this.policies,
    );
  }
}
