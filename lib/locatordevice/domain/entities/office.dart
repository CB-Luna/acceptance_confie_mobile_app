class Office {
  final String id;
  final String name;
  final String address;
  final String? phone;
  final double latitude;
  final double longitude;
  final double distanceInMiles;

  Office({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.phone,
    this.distanceInMiles = 0,
  });

  // Método para convertir desde un Map
  factory Office.fromMap(Map<String, dynamic> map) {
    return Office(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      phone: map['phone'],
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
      distanceInMiles: map['distanceInMiles'] ?? 0.0,
    );
  }

  // Método para convertir a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'phone': phone,
      'latitude': latitude,
      'longitude': longitude,
      'distanceInMiles': distanceInMiles,
    };
  }
}
