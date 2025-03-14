import '../../domain/entities/location.dart';
import '../../domain/entities/office.dart';
import '../../domain/repositories/location_repository.dart';
import '../../domain/repositories/office_repository.dart';
import '../datasources/office_datasource.dart';

class OfficeRepositoryImpl implements OfficeRepository {
  final OfficeDataSource officeDataSource;
  final LocationRepository locationRepository;

  OfficeRepositoryImpl(this.officeDataSource, this.locationRepository);

  @override
  Future<List<Office>> getAllOffices() => officeDataSource.getAllOffices();

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
