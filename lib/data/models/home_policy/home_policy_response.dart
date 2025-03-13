import 'vehicle.dart';

class HomePolicyResponse {
  final List<Vehicle> vehicles;

  HomePolicyResponse({required this.vehicles});

  factory HomePolicyResponse.fromJson(List<dynamic> json) {
    final vehicles = json
        .map((item) => Vehicle.fromJson(item as Map<String, dynamic>))
        .toList();
    return HomePolicyResponse(vehicles: vehicles);
  }

  List<dynamic> toJson() =>
      vehicles.map((vehicle) => vehicle.toJson()).toList();
}
