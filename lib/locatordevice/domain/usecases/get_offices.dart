import '../entities/office.dart';
import '../repositories/office_repository.dart';

class GetOffices {
  final OfficeRepository repository;

  GetOffices(this.repository);

  Future<List<Office>> execute() async {
    return await repository.getOffices();
  }
}
