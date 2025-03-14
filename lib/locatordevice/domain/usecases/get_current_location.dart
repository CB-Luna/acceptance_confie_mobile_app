import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../repositories/location_repository.dart';

class GetCurrentLocation {
  final LocationRepository repository;

  GetCurrentLocation(this.repository);

  Future<Position> execute() async {
    try {
      debugPrint('GetCurrentLocation: Executing use case');
      return await repository.getCurrentLocation();
    } catch (e) {
      debugPrint('GetCurrentLocation: Error executing use case: $e');
      rethrow;
    }
  }
}
