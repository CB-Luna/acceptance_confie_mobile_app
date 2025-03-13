import '../domain/models/office_location.dart';

/// Clase que proporciona datos estáticos de las oficinas de Freeway Insurance
class OfficeData {
  /// Lista de oficinas de Freeway Insurance
  static List<OfficeLocation> getOffices() {
    return [
      // Oficina 1: Chula Vista
      OfficeLocation(
        id: 'chula_vista',
        latitude: 32.6024602,
        longitude: -117.0804273,
        address: 'Seguro de auto en Chula Vista, 91911',
        secondaryAddress: 'California, Chula Vista, California, 91911, USA',
        isOpen: true,
        closeHours: '8pm',
        distanceInMiles: 0, // Se calculará dinámicamente
        reference: '619-399-2387',
        rating: 4.7,
      ),

      // Oficina 2: National City
      OfficeLocation(
        id: 'national_city',
        latitude: 32.6773538,
        longitude: -117.0962897,
        address: 'Seguro de auto en National City, 91950',
        secondaryAddress: 'California',
        isOpen: true,
        closeHours: '8pm',
        distanceInMiles: 0, // Se calculará dinámicamente
        reference: '619-618-2400',
        rating: 4.7,
      ),
    ];
  }
}
