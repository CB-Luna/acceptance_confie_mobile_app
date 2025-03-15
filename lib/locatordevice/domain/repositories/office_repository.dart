import '../entities/office.dart';

abstract class OfficeRepository {
  Future<List<Office>> getOffices();
}
