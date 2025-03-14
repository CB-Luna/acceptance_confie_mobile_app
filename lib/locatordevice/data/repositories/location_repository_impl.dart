import '../../domain/entities/location.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Location?> getCurrentLocation() => dataSource.getCurrentLocation();

  @override
  Future<bool> hasLocationPermission() => dataSource.hasLocationPermission();

  @override
  Future<bool> requestLocationPermission() =>
      dataSource.requestLocationPermission();

  @override
  Future<double> calculateDistance(Location start, Location end) =>
      dataSource.calculateDistance(start, end);
}
