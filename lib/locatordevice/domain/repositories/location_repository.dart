import 'package:geolocator/geolocator.dart';

import '../entities/location.dart';

abstract class LocationRepository {
  /// Gets the current device location
  Future<Position> getCurrentLocation();

  /// Gets a sorted list of offices based on proximity to the current location
  Future<List<Map<String, dynamic>>> getSortedOffices();

  /// Calculate distance between two locations
  Future<double> calculateDistance(Location source, Location destination);
}
