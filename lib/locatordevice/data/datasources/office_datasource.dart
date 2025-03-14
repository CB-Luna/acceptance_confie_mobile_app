import 'package:flutter/foundation.dart';

abstract class OfficeDataSource {
  Future<List<Map<String, dynamic>>> getOffices();
}

class OfficeDataSourceImpl implements OfficeDataSource {
  @override
  Future<List<Map<String, dynamic>>> getOffices() async {
    // Mock data for now - would be replaced with actual API calls
    debugPrint('OfficeDataSourceImpl: Getting offices');

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      // Oficina 1: Chula Vista
      {
        'id': 'chula_vista',
        'latitude': 32.6024602,
        'longitude': -117.0804273,
        'address': 'Seguro de auto en Chula Vista, 91911',
        'secondaryAddress': 'California, Chula Vista, California, 91911, USA',
        'isOpen': true,
        'closeHours': '8pm',
        'distanceInMiles': 0, // Se calculará dinámicamente
        'reference': '619-399-2387',
        'rating': 4.7,
      },

      // Oficina 2: National City
      {
        'id': 'national_city',
        'latitude': 32.6773538,
        'longitude': -117.0962897,
        'address': 'Seguro de auto en National City, 91950',
        'secondaryAddress': 'California',
        'isOpen': true,
        'closeHours': '8pm',
        'distanceInMiles': 0, // Se calculará dinámicamente
        'reference': '619-618-2400',
        'rating': 4.7,
      },
    ];
  }
}
