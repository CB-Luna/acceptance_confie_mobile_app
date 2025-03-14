import '../entities/location.dart';
import '../entities/office.dart';
import '../repositories/office_repository.dart';

class GetSortedOffices {
  final OfficeRepository repository;

  GetSortedOffices(this.repository);

  Future<List<Office>> call(Location currentLocation) async {
    final offices = await repository.getOfficesWithDistances(currentLocation);
    offices.sort((a, b) => (a.distance ?? double.infinity)
        .compareTo(b.distance ?? double.infinity));
    return offices;
  }
}
