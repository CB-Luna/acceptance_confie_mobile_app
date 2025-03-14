import 'package:geolocator/geolocator.dart';

import '../../domain/entities/location.dart';

abstract class LocationDataSource {
  Future<Location?> getCurrentLocation();
  Future<bool> hasLocationPermission();
  Future<bool> requestLocationPermission();
  Future<double> calculateDistance(Location start, Location end);
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<Location?> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return Location(
        latitude: position.latitude,
        longitude: position.longitude,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> hasLocationPermission() async {
    final LocationPermission permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> requestLocationPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<double> calculateDistance(Location start, Location end) async {
    return Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
  }
}
