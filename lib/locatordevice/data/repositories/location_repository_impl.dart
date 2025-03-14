import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_data_source.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource locationDataSource;

  LocationRepositoryImpl({required this.locationDataSource});

  @override
  Future<Position> getCurrentLocation() async {
    try {
      debugPrint('LocationRepositoryImpl: Getting current location');
      final position = await locationDataSource.getCurrentPosition();
      return position;
    } catch (e) {
      debugPrint('LocationRepositoryImpl: Error getting current location: $e');
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getSortedOffices() async {
    // Mock data for now - would be replaced with actual API calls
    debugPrint('LocationRepositoryImpl: Getting sorted offices');

    try {
      final currentPosition = await getCurrentLocation();

      // Sample office data
      final offices = [
        {
          'name': 'Office Downtown',
          'address': '123 Main St',
          'latitude': currentPosition.latitude + 0.01,
          'longitude': currentPosition.longitude - 0.01,
          'phone': '555-1234',
        },
        {
          'name': 'Office Uptown',
          'address': '456 High St',
          'latitude': currentPosition.latitude - 0.02,
          'longitude': currentPosition.longitude + 0.02,
          'phone': '555-5678',
        },
        {
          'name': 'Office Midtown',
          'address': '789 Center Ave',
          'latitude': currentPosition.latitude + 0.03,
          'longitude': currentPosition.longitude + 0.03,
          'phone': '555-9012',
        },
      ];

      // Sort by distance from current location
      offices.sort((a, b) {
        final distanceA = Geolocator.distanceBetween(
          currentPosition.latitude,
          currentPosition.longitude,
          a['latitude'] as double,
          a['longitude'] as double,
        );

        final distanceB = Geolocator.distanceBetween(
          currentPosition.latitude,
          currentPosition.longitude,
          b['latitude'] as double,
          b['longitude'] as double,
        );

        return distanceA.compareTo(distanceB);
      });

      debugPrint(
        'LocationRepositoryImpl: Returning ${offices.length} sorted offices',
      );
      return offices;
    } catch (e) {
      debugPrint('LocationRepositoryImpl: Error getting sorted offices: $e');
      rethrow;
    }
  }

  @override
  Future<double> calculateDistance(
    Location source,
    Location destination,
  ) async {
    return Geolocator.distanceBetween(
      source.latitude,
      source.longitude,
      destination.latitude,
      destination.longitude,
    );
  }
}
