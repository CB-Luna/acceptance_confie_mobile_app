class User {
  final String username;
  final String fullName;
  final String policyNumber;
  final DateTime nextPayment;
  final String policyType;
  final int customerId; // Añadido para poder hacer la llamada a la API
  final String? email; // Añadido para información de contacto
  final String? phone; // Añadido para información de contacto

  User({
    required this.username,
    required this.fullName,
    required this.policyNumber,
    required this.nextPayment,
    required this.policyType,
    required this.customerId,
    this.email,
    this.phone,
  });
}
