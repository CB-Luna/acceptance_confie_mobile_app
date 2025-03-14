import 'location.dart';

class Office {
  final String id;
  final String name;
  final String address;
  final Location location;
  final String? phoneNumber;
  final String? schedule;
  final double? distance;

  const Office({
    required this.id,
    required this.name,
    required this.address,
    required this.location,
    this.phoneNumber,
    this.schedule,
    this.distance,
  });

  Office copyWith({
    String? id,
    String? name,
    String? address,
    Location? location,
    String? phoneNumber,
    String? schedule,
    double? distance,
  }) {
    return Office(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      schedule: schedule ?? this.schedule,
      distance: distance ?? this.distance,
    );
  }
}
