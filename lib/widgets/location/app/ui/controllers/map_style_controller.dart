import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../utils/map_style.dart';

class MapStyleController {
  int _currentStyleIndex = 0;
  final List<String?> _styles = [
    null, // Estilo por defecto de Google Maps
    MapStyle.style1,
    MapStyle.style2
  ];

  // Getter para obtener el estilo actual del mapa
  // Este getter se usa directamente en la propiedad style del widget GoogleMap
  String? get currentMapStyle => _styles[_currentStyleIndex];

  // Método para cambiar al siguiente estilo de mapa
  void changeMapStyle() {
    _currentStyleIndex = (_currentStyleIndex + 1) % _styles.length;
    debugPrint(
        '✅ Map style changed to style ${_currentStyleIndex == 0 ? "default" : _currentStyleIndex}');
  }

  // Este método se mantiene para compatibilidad con el código existente
  // pero ya no utiliza el método obsoleto setMapStyle()
  void initMapController(GoogleMapController controller) {
    // No hacemos nada con el controlador, ya que el estilo se aplica
    // directamente a través de la propiedad style del widget GoogleMap
    debugPrint('✅ Map controller initialized');
  }
}
