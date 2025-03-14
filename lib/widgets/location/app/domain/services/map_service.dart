import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';

import '../../data/office_data.dart';
import '../entities/location.dart';

class MapService {
  // Método para verificar y solicitar permisos de ubicación
  Future<bool> checkLocationPermission({bool requestIfDenied = true}) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Primero verificamos si los servicios de ubicación están habilitados
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('⚠️ Los servicios de ubicación están desactivados');
      return false;
    }

    // Verificar el estado actual de los permisos
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Si se deniegan los permisos y queremos solicitarlos
      if (requestIfDenied) {
        debugPrint('📍 Solicitando permisos de ubicación...');
        permission = await Geolocator.requestPermission();

        // Verificar el resultado de la solicitud
        if (permission == LocationPermission.denied) {
          debugPrint('❌ El usuario denegó los permisos de ubicación');
          return false;
        }
      } else {
        return false;
      }
    }

    // Verificar si los permisos están permanentemente denegados
    if (permission == LocationPermission.deniedForever) {
      debugPrint('❌ Los permisos de ubicación están permanentemente denegados');
      return false;
    }

    // Si llegamos aquí, tenemos permisos
    debugPrint('✅ Permisos de ubicación concedidos: $permission');
    return true;
  }

  Future<Location> getCurrentLocation() async {
    // Número máximo de intentos para obtener la ubicación
    const maxAttempts = 5;

    // Verificar permisos primero
    final hasPermission = await checkLocationPermission();
    if (!hasPermission) {
      debugPrint(
          '⚠️ Sin permisos de ubicación, usando ubicación predeterminada',);
      return const Location(latitude: 32.5149, longitude: -117.0382); // Tijuana
    }

    for (int attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        debugPrint(
            '📍 Intento $attempt de $maxAttempts para obtener la ubicación actual',);

        // Verificar si la ubicación está habilitada
        final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
        debugPrint('📍 Servicios de ubicación habilitados: $isLocationEnabled');

        if (!isLocationEnabled) {
          throw Exception('Los servicios de ubicación están desactivados');
        }

        // Primero intentar con la mayor precisión posible
        debugPrint('📍 Obteniendo ubicación con precisión BEST...');
        final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
          timeLimit: const Duration(seconds: 20),
          forceAndroidLocationManager: false,
        );

        // Verificar que las coordenadas no sean cero (indicador de posible problema)
        if (position.latitude == 0 && position.longitude == 0) {
          debugPrint(
              '⚠️ Se obtuvo una ubicación con coordenadas (0,0). Posible error.',);
          throw Exception('Coordenadas inválidas (0,0)');
        }

        // Verificar que la precisión sea aceptable
        if (position.accuracy > 500) {
          // Si la precisión es peor que 500 metros
          debugPrint(
              '⚠️ Precisión de ubicación demasiado baja: ${position.accuracy} metros',);
          if (attempt < maxAttempts) {
            // Intentar de nuevo si la precisión es mala
            continue;
          }
        }

        debugPrint(
            '📍 Ubicación actual obtenida: (${position.latitude}, ${position.longitude})',);
        debugPrint('📍 Precisión: ${position.accuracy} metros');
        return Location(
            latitude: position.latitude, longitude: position.longitude,);
      } catch (e) {
        debugPrint(
            '❌ Error al obtener la ubicación actual (intento $attempt): $e',);

        // Si no es el último intento, esperar antes de intentar de nuevo
        if (attempt < maxAttempts) {
          await Future.delayed(const Duration(seconds: 3));
        }
      }
    }

    // Si después de todos los intentos no se pudo obtener la ubicación, devolver la ubicación de Tijuana como predeterminada
    debugPrint(
        '⚠️ No se pudo obtener la ubicación actual después de $maxAttempts intentos. Usando ubicación predeterminada de Tijuana.',);
    // Coordenadas aproximadas de Tijuana
    return const Location(latitude: 32.5149, longitude: -117.0382);
  }

  Future<List<Location>> searchNearbyPlaces(
    Location center, {
    double radius = 1000,
  }) async {
    // TODO: Implement Google Places API integration
    return [];
  }

  // Implementación mejorada de geocodificación inversa para obtener direcciones precisas
  Future<String> getAddressFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      // Primero verificar si las coordenadas coinciden con alguna oficina conocida
      final officeAddress = _getOfficeAddress(latitude, longitude);
      if (officeAddress != null) {
        return officeAddress;
      }

      final List<geocoding.Placemark> placemarks = 
          await geocoding.placemarkFromCoordinates(latitude, longitude);
      
      if (placemarks.isEmpty) return 'Dirección no encontrada';

      final place = placemarks.first;
      final List<String> addressParts = [];

      // Construir dirección más detallada y en español
      if (place.street?.isNotEmpty ?? false) addressParts.add(place.street!);
      if (place.subLocality?.isNotEmpty ?? false) addressParts.add(place.subLocality!);
      if (place.locality?.isNotEmpty ?? false) addressParts.add(place.locality!);
      if (place.administrativeArea?.isNotEmpty ?? false) {
        addressParts.add('${place.administrativeArea!}, ${place.country ?? ""}');
      }

      return addressParts.join(', ');
    } catch (e) {
      debugPrint('Error en geocodificación: $e');
      return _getOfficeAddress(latitude, longitude) ?? 
             'Ubicación cerca de San Diego, CA';
    }
  }

  String? _getOfficeAddress(double latitude, double longitude) {
    // Obtener las oficinas de OfficeData
    final offices = OfficeData.getOffices();
    
    // Buscar una coincidencia exacta o cercana
    for (final office in offices) {
      // Aumentar el margen de error para coincidencias (aproximadamente 500 metros)
      if ((office.latitude - latitude).abs() < 0.005 &&
          (office.longitude - longitude).abs() < 0.005) {
        return '${office.address}\n${office.secondaryAddress}';
      }
    }
    return null;
  }
}
