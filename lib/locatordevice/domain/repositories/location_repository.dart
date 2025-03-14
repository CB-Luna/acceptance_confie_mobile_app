import '../entities/location.dart';

abstract class LocationRepository {
  Future<Location?> getCurrentLocation();
  Future<bool> hasLocationPermission();
  Future<bool> requestLocationPermission();
  Future<double> calculateDistance(Location start, Location end);
}
