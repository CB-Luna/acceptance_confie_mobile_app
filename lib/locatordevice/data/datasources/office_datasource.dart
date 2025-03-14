import '../../domain/entities/location.dart';
import '../../domain/entities/office.dart';

abstract class OfficeDataSource {
  Future<List<Office>> getAllOffices();
}

class OfficeDataSourceImpl implements OfficeDataSource {
  @override
  Future<List<Office>> getAllOffices() async {
    // Return real office data converted to our domain model
    return [
      const Office(
        id: 'chula_vista',
        name: 'Chula Vista',
        address: 'Seguro de auto en Chula Vista, 91911',
        location: Location(
          latitude: 32.6024602,
          longitude: -117.0804273,
        ),
        phoneNumber: '619-399-2387',
        schedule: 'Abierto hasta las 8pm',
      ),
      const Office(
        id: 'national_city',
        name: 'National City',
        address: 'Seguro de auto en National City, 91950',
        location: Location(
          latitude: 32.6773538,
          longitude: -117.0962897,
        ),
        phoneNumber: '619-618-2400',
        schedule: 'Abierto hasta las 8pm',
      ),
      const Office(
        id: 'central_office',
        name: 'Oficina Central',
        address: 'Av. Reforma 123, Ciudad de México',
        location: Location(
          latitude: 19.4326,
          longitude: -99.1332,
        ),
        phoneNumber: '(55) 5123-4567',
        schedule: 'Lun-Vie 9:00-18:00',
      ),
      const Office(
        id: 'north_office',
        name: 'Sucursal Norte',
        address: 'Blvd. Manuel Ávila Camacho 2000, Naucalpan',
        location: Location(
          latitude: 19.4890,
          longitude: -99.2377,
        ),
        phoneNumber: '(55) 5123-8901',
        schedule: 'Lun-Vie 8:00-17:00, Sáb 9:00-13:00',
      ),
    ];
  }
}
