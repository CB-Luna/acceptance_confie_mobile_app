import '../entities/location.dart';
import '../entities/office.dart';

abstract class OfficeRepository {
  /// Gets all offices
  Future<List<Map<String, dynamic>>> getOffices();

  /// Gets all offices as domain entities
  Future<List<Office>> getAllOffices();

  /// Gets offices with calculated distances from current location
  Future<List<Office>> getOfficesWithDistances(Location currentLocation);
}
