import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../../data/models/office/office.dart';
import '../../../data/services/office_service.dart';

class GetOffices {
  final OfficeService officeService;

  GetOffices(this.officeService);

  Future<List<Office>> execute({Position? currentPosition}) async {
    try {
      debugPrint('GetOffices: Executing use case');

      List<Office> offices;

      if (currentPosition != null) {
        // Si tenemos la posición actual, usar las coordenadas para obtener oficinas cercanas
        offices = await officeService.getNearbyOfficesByLocation(
          currentPosition.latitude,
          currentPosition.longitude,
        );
      } else {
        // Si no tenemos posición, usar un código postal predeterminado
        // Esto solo debería ocurrir en casos excepcionales
        offices = await officeService.getNearbyOfficesByZipCode('91911');
      }

      // Asegurarnos de que todas las oficinas tengan distancia calculada
      // Esto es importante porque algunas APIs podrían no incluir la distancia
      if (currentPosition != null) {
        final officesWithDistances = offices.toList();

        // Ordenar por distancia
        officesWithDistances.sort(
          (a, b) => a.distanceObj.value.compareTo(b.distanceObj.value),
        );

        return officesWithDistances;
      }

      return offices;
    } catch (e) {
      debugPrint('GetOffices: Error executing use case: $e');
      rethrow;
    }
  }
}
