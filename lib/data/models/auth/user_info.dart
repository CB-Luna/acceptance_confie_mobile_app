class UserInfo {
  final String fullName;
  final String email;
  final String phone;
  final String policyNumber;
  final String policyType;
  final String customerId;
  final String? avatar;
  final String? languageCode;
  final String street;

  UserInfo({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.policyNumber,
    required this.policyType,
    required this.customerId,
    required this.street,
    this.avatar,
    this.languageCode,
  });

  // Crear un UserInfo con valores por defecto para cuando no hay información disponible
  factory UserInfo.defaultInfo({
    required String email,
    String? customerId,
  }) {
    return UserInfo(
      fullName: 'Freeway User',
      email: email,
      phone: '+1 (555) 123-4567',
      policyNumber:
          customerId != null ? 'POLICY-$customerId' : 'POLICY-DEFAULT',
      policyType: 'Auto Policy',
      customerId: customerId ?? 'DEFAULT-ID',
      avatar: null,
      languageCode: 'en_US',
      street: '123 Main St',
    );
  }
}
