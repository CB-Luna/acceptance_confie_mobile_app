import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/models/map_marker.dart';
import '../../domain/models/office_location.dart';
import '../../domain/services/map_service.dart';
import '../utils/distance_calculator.dart';

class MarkerController {
  final Set<Marker> _markers = {};
  int _markerCounter = 1;
  bool _markerMode = false;
  BitmapDescriptor? _customMarkerIcon;

  // Añadimos un marcador especial para la flecha roja
  Marker? _redArrowMarker;
  BitmapDescriptor? _redArrowIcon;
  bool _redArrowMode = false;

  // Callback para notificar cuando un marcador es arrastrado
  Function(String, LatLng)? onMarkerDragged;

  // Callback para cuando se selecciona una oficina cercana
  Function(OfficeLocation, double, double)? onNearestOfficeFound;

  // Instancia del servicio de mapas para obtener direcciones
  final MapService _mapService = MapService();

  // Getters
  Set<Marker> get markers => _markers;
  bool get markerMode => _markerMode;
  Marker? get redArrowMarker => _redArrowMarker;
  bool get redArrowMode => _redArrowMode;

  // Método para registrar el callback de arrastre
  void setOnMarkerDraggedCallback(Function(String, LatLng) callback) {
    onMarkerDragged = callback;
  }

  // Método para registrar el callback cuando se encuentra la oficina más cercana
  void setOnNearestOfficeFoundCallback(
    Function(OfficeLocation, double, double) callback,
  ) {
    onNearestOfficeFound = callback;
  }

  // Método mejorado para cargar el icono personalizado desde un archivo de imagen
  Future<void> loadCustomMarker() async {
    if (_customMarkerIcon != null) return;

    try {
      // Intentar cargar el icono personalizado
      final Uint8List markerIcon = await getBytesFromAsset(
        'assets/prefix.png',
        120,
      );
      _customMarkerIcon = BitmapDescriptor.bytes(markerIcon);
      debugPrint('✅ Custom marker icon loaded successfully from prefix.png');
    } catch (e) {
      debugPrint('❌ Error loading custom marker icon: $e');
      // En caso de error, usar un icono predeterminado de Google Maps
      _customMarkerIcon =
          BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
      debugPrint('✅ Using default blue marker as fallback');
    }
  }

  // Método para cargar el icono de ubicación del usuario (círculo azul)
  Future<void> loadRedArrowIcon() async {
    if (_redArrowIcon != null) return;

    try {
      // Intentar cargar un icono personalizado para la ubicación del usuario
      final Uint8List markerIcon = await getBytesFromAsset(
        'assets/user_location.png',  // Intentar usar un icono personalizado si existe
        100,
      );
      _redArrowIcon = BitmapDescriptor.bytes(markerIcon);
      debugPrint('✅ User location icon loaded successfully from user_location.png');
    } catch (e) {
      debugPrint('❌ Error loading user location icon: $e');
      
      try {
        // Si no se puede cargar el icono personalizado, crear un círculo azul
        final BitmapDescriptor customCircle = await _createCircleMarkerIcon(
          Colors.blue,  // Color azul para el círculo
          Colors.white,  // Color blanco para el borde
        );
        _redArrowIcon = customCircle;
        debugPrint('✅ Created custom blue circle icon for user location');
      } catch (e2) {
        debugPrint('❌ Error creating custom circle icon: $e2');
        // En caso de error, usar un icono predeterminado de Google Maps
        _redArrowIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
        debugPrint('✅ Using default azure marker as fallback');
      }
    }
  }



  // Método auxiliar para obtener los bytes de una imagen de assets con el tamaño correcto
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    try {
      final ByteData data = await rootBundle.load(path);
      final ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width,
        targetHeight: width,
      );
      final ui.FrameInfo fi = await codec.getNextFrame();
      final ByteData? newData = await fi.image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      if (newData == null) throw Exception('Could not get image bytes');
      return newData.buffer.asUint8List();
    } catch (e) {
      throw Exception('Failed to load asset: $path - $e');
    }
  }

  // Método para activar/desactivar el modo de marcadores
  bool toggleMarkerMode() {
    _markerMode = !_markerMode;
    return _markerMode;
  }

  // Método para activar/desactivar el modo de marcador de flecha roja
  bool toggleRedArrowMode() {
    _redArrowMode = !_redArrowMode;
    if (!_redArrowMode && _redArrowMarker != null) {
      _redArrowMarker = null; // Eliminar el marcador si se desactiva el modo
    }
    return _redArrowMode;
  }
  
  // Método para crear un icono de marcador circular
  Future<BitmapDescriptor> _createCircleMarkerIcon(
    Color fillColor,
    Color borderColor,
  ) async {
    const size = Size(120.0, 120.0);
    final pictureRecorder = ui.PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    
    // Dibujar el círculo exterior (borde)
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2, borderPaint);
    
    // Dibujar el círculo interior
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 2.4, fillPaint);
    
    // Dibujar un punto central
    final centerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), size.width / 8, centerPaint);
    
    // Convertir a imagen
    final img = await pictureRecorder.endRecording().toImage(
          size.width.toInt(),
          size.height.toInt(),
        );
    final data = await img.toByteData(format: ui.ImageByteFormat.png);
    
    return BitmapDescriptor.bytes(data!.buffer.asUint8List());
  }

  // Método para añadir un marcador con ajustes para mejor visualización
  void addMarker(LatLng position) {
    // Siempre mostrar los marcadores de oficinas, sin importar el modo
    // Eliminamos la verificación de _markerMode para que siempre se muestren

    final markerId = position.toString();
    final officeName = 'Office $_markerCounter';
    _markerCounter++;

    // Verificación explícita del icono personalizado
    final icon = _customMarkerIcon ??
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed); // Cambiamos a rojo para las oficinas

    final mapMarker = MapMarkerModel(
      id: markerId,
      title: 'Freeway Insurance',
      snippet: 'Oficina $_markerCounter',
      position: position,
      icon: icon,
      onDragEnd: _updateMarkerPosition,
      visible: true, // Aseguramos que sea visible
    );

    _markers.add(mapMarker.toMarker());
    debugPrint(
      'Added marker: $officeName at ${position.latitude}, ${position.longitude}',
    );
  }

  // Método para añadir o actualizar el marcador de ubicación del usuario (solo permite uno a la vez)
  void addOrUpdateRedArrowMarker(LatLng position) {
    final markerId = const MarkerId('user_location_marker');

    // Crear un icono personalizado para la ubicación del usuario si no existe
    _redArrowIcon ??= BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);

    // Solo se permite un marcador de ubicación a la vez
    _redArrowMarker = Marker(
      markerId: markerId,
      position: position,
      icon: _redArrowIcon!,
      infoWindow: const InfoWindow(
        title: 'Tu Ubicación Actual',
        snippet: 'Toca para encontrar la oficina más cercana',
      ),
      draggable: true,
      onDragEnd: _updateRedArrowPosition,
      onTap: () => _findNearestOffice(position),
      anchor: const Offset(0.5, 1.0), // Ancla en la parte inferior del icono
      visible: true,  // Asegurar que el marcador sea visible
      zIndex: 2,  // Mayor prioridad que los marcadores de oficinas
    );

    debugPrint(
      'User location marker set at: ${position.latitude}, ${position.longitude}',
    );
  }

  // Método actualizado para manejar el arrastre de marcadores con notificación
  void _updateMarkerPosition(MarkerId markerId, LatLng newPosition) {
    // Buscar el marcador en el conjunto para actualizarlo visualmente
    final updatedMarkers = _markers.map((marker) {
      if (marker.markerId == markerId) {
        // Crear un marcador actualizado con la nueva posición
        final updatedMarker = Marker(
          markerId: markerId,
          position: newPosition,
          icon: marker.icon,
          infoWindow: marker.infoWindow,
          draggable: true,
          anchor: const Offset(0.5, 1.0),
          onDragEnd: (LatLng position) {
            _updateMarkerPosition(markerId, position);
          },
        );
        return updatedMarker;
      }
      return marker;
    }).toSet();

    _markers.clear();
    _markers.addAll(updatedMarkers);

    debugPrint(
      'Marker ${markerId.value} moved to: ${newPosition.latitude}, ${newPosition.longitude}',
    );

    // Notificar a través del callback si está configurado
    if (onMarkerDragged != null) {
      onMarkerDragged!(markerId.value, newPosition);
    }
  }

  // Método para actualizar la posición del marcador de flecha roja cuando se arrastra
  void _updateRedArrowPosition(LatLng newPosition) {
    addOrUpdateRedArrowMarker(newPosition);
    debugPrint(
      'Red arrow marker moved to: ${newPosition.latitude}, ${newPosition.longitude}',
    );
  }

  // Método actualizado para calcular la oficina más cercana con dirección real
  Future<void> _findNearestOffice(LatLng userPosition) async {
    if (_markers.isEmpty) {
      debugPrint('No office markers available to calculate nearest one');
      return;
    }

    try {
      // Convertir los marcadores de oficina a formato para el cálculo
      final officesList = _markers.map((marker) {
        final position = marker.position;
        final id = marker.markerId.value;
        final title = marker.infoWindow.title ?? 'Office';

        return {
          'id': id,
          'latitude': position.latitude,
          'longitude': position.longitude,
          'address': title,
          'secondaryAddress': marker.infoWindow.snippet ?? 'Office Location',
        };
      }).toList();

      // Encontrar la oficina más cercana
      final nearestOfficeData = DistanceCalculator.findNearestOffice(
        userPosition.latitude,
        userPosition.longitude,
        officesList,
      );

      // Obtener la dirección real de las coordenadas
      final officeLat = nearestOfficeData['latitude'] as double;
      final officeLon = nearestOfficeData['longitude'] as double;

      // Obtener la dirección real mediante geocodificación inversa
      String formattedAddress;
      try {
        formattedAddress = await _mapService.getAddressFromCoordinates(
          officeLat,
          officeLon,
        );
      } catch (e) {
        formattedAddress = nearestOfficeData['address'] as String;
        debugPrint('Error obteniendo dirección, usando título alternativo: $e');
      }

      // Crear objeto OfficeLocation con la dirección real
      final nearestOffice = OfficeLocation(
        id: nearestOfficeData['id'] as String,
        latitude: officeLat,
        longitude: officeLon,
        address: formattedAddress, // Usamos la dirección obtenida de la API
        secondaryAddress: nearestOfficeData['secondaryAddress'] as String,
        isOpen: true, // Default values
        closeHours: '5:00 PM', // Default values
        distanceInMiles: nearestOfficeData['distanceInMiles'] as double,
      );

      debugPrint(
        'Found nearest office: ${nearestOffice.address}, distance: ${nearestOffice.distanceInMiles.toStringAsFixed(2)} miles',
      );

      // Notificar a través del callback
      if (onNearestOfficeFound != null) {
        onNearestOfficeFound!(
          nearestOffice,
          userPosition.latitude,
          userPosition.longitude,
        );
      }
    } catch (e) {
      debugPrint('❌ Error finding nearest office: $e');
    }
  }

  // Método actualizado para limpiar todos los marcadores, incluido el marcador rojo
  void clearMarkers() {
    _markers.clear();
    _markerCounter = 1;
    _redArrowMarker = null; // También elimina el marcador rojo
    debugPrint('All markers have been cleared');
  }

  // Método para obtener todos los marcadores (incluyendo la flecha roja)
  Set<Marker> getAllMarkers() {
    final result = Set<Marker>.from(_markers);
    if (_redArrowMarker != null) {
      result.add(_redArrowMarker!);
    }
    return result;
  }
}
