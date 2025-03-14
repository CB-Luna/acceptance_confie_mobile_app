import 'location.dart';

class Office {
  final int id;
  final String name;
  final String address;
  final Location location;
  final String phone;
  final double? distance;

  Office({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    required this.phone,
    this.distance,
  });

  Office copyWith({
    int? id,
    String? name,
    String? address,
    Location? location,
    String? phone,
    double? distance,
  }) {
    return Office(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      phone: phone ?? this.phone,
      distance: distance ?? this.distance,
    );
  }
}
