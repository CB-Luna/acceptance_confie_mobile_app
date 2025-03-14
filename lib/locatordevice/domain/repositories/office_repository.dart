import '../entities/location.dart';
import '../entities/office.dart';

abstract class OfficeRepository {
  Future<List<Office>> getAllOffices();
  Future<List<Office>> getOfficesWithDistances(Location currentLocation);
}
