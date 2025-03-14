import 'package:flutter/foundation.dart';

import '../../domain/entities/location.dart';
import '../../domain/entities/office.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/office_repository.dart';
import '../datasources/office_datasource.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final OfficeDataSource officeDataSource;
  final LocationRepository locationRepository;

  OfficeRepositoryImpl({
    required this.officeDataSource,
    required this.locationRepository,
  });

  @override
  Future<List<Map<String, dynamic>>> getOffices() async {
    try {
      debugPrint('OfficeRepositoryImpl: Getting offices');
      return await officeDataSource.getOffices();
    } catch (e) {
      debugPrint('OfficeRepositoryImpl: Error getting offices: $e');
      rethrow;
    }
  }

  @override
  Future<List<Office>> getAllOffices() async {
    final officesData = await getOffices();
    return officesData
        .map(
          (data) => Office(
            id: data['id'] as int,
            name: data['name'] as String,
            address: data['address'] as String,
            location: Location(
              latitude: data['latitude'] as double,
              longitude: data['longitude'] as double,
            ),
            phone: data['phone'] as String,
          ),
        )
        .toList();
  }

  @override
  Future<List<Office>> getOfficesWithDistances(Location currentLocation) async {
    final offices = await getAllOffices();
    final List<Office> officesWithDistance = [];

    for (var office in offices) {
      final distance = await locationRepository.calculateDistance(
        currentLocation,
        office.location,
      );
      officesWithDistance.add(office.copyWith(distance: distance));
    }

    return officesWithDistance;
  }
}
