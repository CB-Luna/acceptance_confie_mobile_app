import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/office_data.dart';
import '../../domain/models/office_location.dart';
import '../../domain/services/map_service.dart';
import '../controllers/map_style_controller.dart';
import '../controllers/marker_controller.dart';
import '../utils/snackbar_helper.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  MapWidgetState createState() => MapWidgetState();
}

class MapWidgetState extends State<MapWidget> {
  GoogleMapController? mapController;
  bool _styleLoaded = false;
  bool _markerIconLoaded = false;
  bool _redArrowIconLoaded = false;

  // Variables para el panel deslizable
  bool _showOfficePanel = false;
  OfficeLocation? _nearestOffice;
  double _userLatitude = 0;
  double _userLongitude = 0;

  // Indicador de carga para la obtención de la dirección
  bool _isLoadingAddress = false;
  // Dirección real obtenida de la API de geocodificación inversa
  String? _formattedAddress;

  // Variables para la dirección del marcador rojo (ubicación del usuario)
  bool _isLoadingUserAddress = false;
  String? _userFormattedAddress;

  // Controladores refactorizados
  final MapStyleController _styleController = MapStyleController();
  final MarkerController _markerController = MarkerController();
  // Servicio para obtener la dirección real
  final MapService _mapService = MapService();

  // Posición inicial del mapa (será actualizada con la ubicación real)
  CameraPosition _initialPosition = const CameraPosition(
    target: LatLng(33.987407, -118.269281), // Posición predeterminada
    zoom: 13,
  );
  
  // Indicador de si ya se cargó la ubicación del usuario
  bool _userLocationLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadMarkerIcon();
    _loadRedArrowIcon();

    // Registramos los callbacks
    _markerController.setOnMarkerDraggedCallback(_notifyMarkerDragged);
    _markerController.setOnNearestOfficeFoundCallback(_showNearestOfficePanel);
    
    // Obtener la ubicación actual del dispositivo con un pequeño retraso
    // para evitar problemas de inicialización
    Future.delayed(const Duration(milliseconds: 300), () {
      _getCurrentDeviceLocation();
    });
    
    // Cargar los marcadores de las oficinas de Freeway Insurance
    _loadOfficeMarkers();
  }
  
  // Método para cargar los marcadores de las oficinas de Freeway Insurance
  void _loadOfficeMarkers() {
    // Obtener la lista de oficinas desde OfficeData
    final offices = OfficeData.getOffices();
    
    // Agregar un marcador para cada oficina
    for (final office in offices) {
      final position = LatLng(office.latitude, office.longitude);
      _markerController.addMarker(position);
    }
    
    debugPrint('📍 Cargados ${offices.length} marcadores de oficinas');
  }
  
  // Método para obtener la ubicación actual del dispositivo
  Future<void> _getCurrentDeviceLocation() async {
    // Mostrar indicador de carga
    if (mounted) {
      setState(() {
        _userLocationLoaded = false;
      });
    }
    
    try {
      debugPrint('📍 Obteniendo ubicación del dispositivo...');
      final location = await _mapService.getCurrentLocation();
      
      // Verificar si la ubicación obtenida es la predeterminada (Los Ángeles)
      final isDefaultLocation = 
          location.latitude == 33.987407 && location.longitude == -118.269281;
      
      if (isDefaultLocation) {
        debugPrint('⚠️ Se obtuvo la ubicación predeterminada. Intentando de nuevo...');
        // Mostrar un mensaje al usuario
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Intentando obtener tu ubicación actual...'),
              duration: Duration(seconds: 3),
            ),
          );
        }
        // Intentar obtener la ubicación nuevamente después de un breve retraso
        await Future.delayed(const Duration(seconds: 2));
        return _getCurrentDeviceLocation();
      }
      
      if (mounted) {
        setState(() {
          // Actualizar la posición inicial del mapa con la ubicación actual
          _initialPosition = CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 13,
          );
          _userLocationLoaded = true;
          
          // Si ya tenemos el controlador del mapa, mover la cámara a la nueva posición
          // Usamos un try-catch para manejar posibles errores de comunicación con el canal
          if (mapController != null) {
            try {
              debugPrint('📍 Intentando mover cámara a la ubicación actual: (${location.latitude}, ${location.longitude})');
              // Usamos moveCamara en lugar de animateCamera para reducir la probabilidad de errores
              mapController!.moveCamera(
                CameraUpdate.newCameraPosition(_initialPosition),
              );
            } catch (e) {
              debugPrint('❌ Error al mover la cámara: $e');
              // No hacemos nada más, ya que la posición inicial ya está actualizada
              // y se usará cuando el mapa se reconstruya
            }
          }
          
          // Guardar las coordenadas del usuario para usarlas en otras funciones
          _userLatitude = location.latitude;
          _userLongitude = location.longitude;
          
          // Agregar un marcador en la ubicación actual del usuario
          _markerController.addOrUpdateRedArrowMarker(
            LatLng(location.latitude, location.longitude)
          );
          
          // Obtener la dirección formateada para la ubicación actual
          _getUserAddress(location.latitude, location.longitude);
          
          debugPrint('📍 Ubicación del dispositivo actualizada: (${location.latitude}, ${location.longitude})');
        });
      }
    } catch (e) {
      debugPrint('❌ Error al obtener la ubicación del dispositivo: $e');
      if (mounted) {
        setState(() {
          _userLocationLoaded = true; // Terminar la carga aunque haya error
        });
        
        // Mostrar un mensaje de error al usuario
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('No se pudo obtener tu ubicación: $e'),
            duration: const Duration(seconds: 5),
            action: SnackBarAction(
              label: 'Reintentar',
              onPressed: () => _getCurrentDeviceLocation(),
            ),
          ),
        );
      }
    }
  }

  // Carga el icono personalizado para oficinas
  Future<void> _loadMarkerIcon() async {
    if (_markerIconLoaded) return;
    await _markerController.loadCustomMarker();
    if (mounted) {
      setState(() {
        _markerIconLoaded = true;
      });
    }
  }

  // Carga el icono de flecha roja
  Future<void> _loadRedArrowIcon() async {
    if (_redArrowIconLoaded) return;
    await _markerController.loadRedArrowIcon();
    if (mounted) {
      setState(() {
        _redArrowIconLoaded = true;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    // Evitar reinicialización si ya tenemos un controlador activo
    if (mapController != null) return;

    mapController = controller;
    // Inicializar el controlador de estilo (ahora solo para registro)
    _styleController.initMapController(controller);

    if (mounted) {
      setState(() {
        _styleLoaded = true;
      });
    }

    debugPrint('GoogleMap controller initialized successfully');
    
    // Esperar un momento para asegurar que el mapa esté completamente cargado
    // Esto ayuda a evitar errores de comunicación con el canal
    Future.delayed(const Duration(milliseconds: 500), () {
      // Si ya tenemos la ubicación del usuario, mover la cámara a esa ubicación
      if (_userLocationLoaded && _initialPosition.target.latitude != 33.987407) {
        try {
          debugPrint('📍 Intentando mover cámara a la ubicación del usuario: ${_initialPosition.target.latitude}, ${_initialPosition.target.longitude}');
          // Usamos moveCamara en lugar de animateCamera para reducir la probabilidad de errores
          controller.moveCamera(
            CameraUpdate.newCameraPosition(_initialPosition),
          );
        } catch (e) {
          debugPrint('❌ Error al mover la cámara: $e');
        }
      } else {
        // Si aún no tenemos la ubicación del usuario, intentar obtenerla de nuevo
        _getCurrentDeviceLocation();
      }
    });
  }

  // Método para cambiar el estilo del mapa
  void _changeMapStyle() {
    // Cambiar al siguiente estilo en el controlador
    _styleController.changeMapStyle();
    
    // Actualizar la UI para que el widget GoogleMap se reconstruya con el nuevo estilo
    // La propiedad style del GoogleMap tomará el valor actualizado de _styleController.currentMapStyle
    setState(() {
      debugPrint('🗺️ Actualizando estilo del mapa en la UI');
    });
  }

  // Método para activar/desactivar el modo de marcadores de oficina
  void _toggleMarkerMode() {
    final isActive = _markerController.toggleMarkerMode();

    setState(() {}); // Actualizar la UI

    SnackbarHelper.showBlueSnackBar(
      context,
      isActive
          ? 'Office marker mode activated - Tap the map to add draggable office markers'
          : 'Office marker mode deactivated',
    );
  }

  // Método para activar/desactivar el modo de marcador de flecha roja
  void _toggleRedArrowMode() {
    final isActive = _markerController.toggleRedArrowMode();

    setState(() {
      // Ocultar el panel si se desactiva el modo de flecha roja
      if (!isActive) {
        _showOfficePanel = false;
        _formattedAddress = null;
      }
    });

    SnackbarHelper.showBlueSnackBar(
      context,
      isActive
          ? 'Red arrow marker mode activated - Tap the map to place your location marker'
          : 'Red arrow marker mode deactivated',
    );
  }

  // Método para notificar cuando un marcador es arrastrado
  void _notifyMarkerDragged(String markerId, LatLng position) {
    SnackbarHelper.showBlueSnackBar(
      context,
      'Office marker moved to: ${position.latitude.toStringAsFixed(4)}, ${position.longitude.toStringAsFixed(4)}',
      duration: const Duration(seconds: 2),
    );
  }

  // Método actualizado para mostrar el panel de la oficina más cercana
  void _showNearestOfficePanel(
    OfficeLocation office,
    double userLat,
    double userLon,
  ) async {
    setState(() {
      _nearestOffice = office;
      _userLatitude = userLat;
      _userLongitude = userLon;
      _showOfficePanel = true;
      _isLoadingAddress = true;
      _formattedAddress = null; // Limpiar la dirección anterior
    });

    // Obtener la dirección real desde las coordenadas
    try {
      final address = await _mapService.getAddressFromCoordinates(
        office.latitude,
        office.longitude,
      );
      if (mounted) {
        setState(() {
          _formattedAddress = address;
          _isLoadingAddress = false;
        });
      }
    } catch (e) {
      debugPrint('Error obteniendo la dirección: $e');
      if (mounted) {
        setState(() {
          _formattedAddress = 'Dirección no disponible';
          _isLoadingAddress = false;
        });
      }
    }

    // Si no tenemos la dirección del usuario, la obtenemos
    if (_userFormattedAddress == null) {
      await _getUserAddress(userLat, userLon);
    }
  }

  // Método mejorado para obtener la dirección del usuario a partir de coordenadas
  Future<void> _getUserAddress(double latitude, double longitude) async {
    // Guardar las coordenadas del usuario para uso posterior
    _userLatitude = latitude;
    _userLongitude = longitude;

    setState(() {
      _isLoadingUserAddress = true;
      _userFormattedAddress = null;
    });

    try {
      debugPrint('Obteniendo dirección para: ($latitude, $longitude)');

      final address = await _mapService.getAddressFromCoordinates(
        latitude,
        longitude,
      );

      // Verificar si la dirección obtenida es válida (no es solo las coordenadas)
      final isDefaultAddress = address.contains('Location at');

      if (mounted) {
        setState(() {
          if (isDefaultAddress) {
            // Si recibimos la dirección por defecto, intentar nuevamente con un pequeño retraso
            debugPrint('Se recibió dirección por defecto, reintentando...');
            _userFormattedAddress = 'Obteniendo dirección precisa...';
            _isLoadingUserAddress = true;

            // Programar un nuevo intento después de un breve retraso
            Future.delayed(const Duration(seconds: 1), () {
              _retryGetUserAddress(latitude, longitude);
            });
          } else {
            // Si recibimos una dirección válida, la mostramos
            _userFormattedAddress = address;
            _isLoadingUserAddress = false;
            debugPrint('Dirección obtenida correctamente: $address');
          }
        });
      }
    } catch (e) {
      debugPrint('Error obteniendo la dirección del usuario: $e');
      if (mounted) {
        setState(() {
          _userFormattedAddress = 'Dirección no disponible';
          _isLoadingUserAddress = false;
        });
      }
    }
  }

  // Método para reintentar obtener la dirección del usuario
  Future<void> _retryGetUserAddress(double latitude, double longitude) async {
    try {
      debugPrint(
          'Reintentando obtener dirección para: ($latitude, $longitude)');

      final address = await _mapService.getAddressFromCoordinates(
        latitude,
        longitude,
      );

      if (mounted) {
        setState(() {
          _userFormattedAddress = address;
          _isLoadingUserAddress = false;
          debugPrint('Dirección obtenida en reintento: $address');
        });
      }
    } catch (e) {
      debugPrint('Error en reintento de obtener dirección: $e');
      if (mounted) {
        setState(() {
          _userFormattedAddress = 'Dirección no disponible';
          _isLoadingUserAddress = false;
        });
      }
    }
  }

  // Método para abrir Google Maps con la ubicación del usuario
  void _openGoogleMapsWithUserLocation() {
    if (_userLatitude == 0 && _userLongitude == 0) {
      SnackbarHelper.showBlueSnackBar(
        context,
        'No user location available',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // Crear la URL para abrir Google Maps en la ubicación del usuario
    final url =
        'https://www.google.com/maps/search/?api=1&query=$_userLatitude,$_userLongitude';
    launchUrl(Uri.parse(url));

    debugPrint(
        'Opening Google Maps at location: $_userLatitude, $_userLongitude');
  }

  // Método para añadir un marcador dependiendo del modo activo
  void _handleMapTap(LatLng position) {
    // Modo de marcador de oficina
    if (_markerController.markerMode) {
      _markerController.addMarker(position);
      setState(() {}); // Actualizar la UI

      SnackbarHelper.showBlueSnackBar(
        context,
        'Added new office marker',
        duration: const Duration(seconds: 2),
      );
    }

    // Modo de marcador de flecha roja
    if (_markerController.redArrowMode) {
      _markerController.addOrUpdateRedArrowMarker(position);
      setState(() {
        _showOfficePanel = false; // Ocultar panel si se mueve el marcador
        _formattedAddress = null;
        _userFormattedAddress = null;
        _isLoadingUserAddress = true;
      }); // Actualizar la UI

      // Obtener la dirección real del marcador rojo (ubicación del usuario)
      _getUserAddress(position.latitude, position.longitude);

      SnackbarHelper.showBlueSnackBar(
        context,
        'Added red location marker - Tap on it to find the nearest office',
        duration: const Duration(seconds: 3),
      );
    }
  }

  // Método para eliminar todos los marcadores
  void _clearMarkers() {
    _markerController.clearMarkers();
    setState(() {
      _showOfficePanel =
          false; // Ocultar el panel cuando se borran los marcadores
      _formattedAddress = null;
      _userFormattedAddress = null;
    }); // Actualizar la UI

    SnackbarHelper.showBlueSnackBar(
      context,
      'All markers have been cleared',
      duration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Usamos una clave única para el widget GoogleMap para evitar problemas de recreación
        GoogleMap(
          key: const ValueKey<String>('google_map_key'),
          onMapCreated: _onMapCreated,
          initialCameraPosition: _initialPosition,
          markers: _markerController.getAllMarkers(),
          onTap: _handleMapTap,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: true,
          mapToolbarEnabled: false,
          // Usar la propiedad style en lugar del método obsoleto setMapStyle()
          style: _styleController.currentMapStyle,
        ),

        // Mostrar indicador de carga mientras se obtiene la ubicación del usuario o se cargan los recursos del mapa
        if (!_styleLoaded || !_markerIconLoaded || !_redArrowIconLoaded || !_userLocationLoaded)
          Container(
            color: const Color.fromRGBO(255, 255, 255, 0.7),
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Obteniendo tu ubicación...', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),

        // Botones de control actualizados con el nuevo estilo
        Positioned(
          top: 16,
          right: 16,
          child: Column(
            children: [
              // Botón para cambiar el estilo del mapa
              Tooltip(
                message: 'Change map style',
                child: FloatingActionButton(
                  onPressed: _changeMapStyle,
                  heroTag: 'btn1',
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0A4DA2),
                  elevation: 4,
                  child: const Icon(Icons.map_outlined),
                ),
              ),
              const SizedBox(height: 10),

              // Botón para activar/desactivar el modo de marcadores de oficina
              Tooltip(
                message: 'Toggle office marker mode',
                child: FloatingActionButton(
                  onPressed: _toggleMarkerMode,
                  heroTag: 'btn2',
                  backgroundColor: _markerController.markerMode
                      ? const Color(0xFF0A4DA2)
                      : Colors.white,
                  foregroundColor: _markerController.markerMode
                      ? Colors.white
                      : const Color(0xFF0A4DA2),
                  elevation: 4,
                  child: Icon(
                    _markerController.markerMode
                        ? Icons.add_location
                        : Icons.add_location_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Botón para activar/desactivar el modo de marcador de flecha roja
              Tooltip(
                message: 'Find nearest office',
                child: FloatingActionButton(
                  onPressed: _toggleRedArrowMode,
                  heroTag: 'btn3',
                  backgroundColor: _markerController.redArrowMode
                      ? const Color(0xFF0A4DA2)
                      : Colors.white,
                  foregroundColor: _markerController.redArrowMode
                      ? Colors.white
                      : const Color(0xFF0A4DA2),
                  elevation: 4,
                  child: Icon(
                    _markerController.redArrowMode
                        ? Icons.place
                        : Icons.place_outlined,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Botón para eliminar todos los marcadores
              Tooltip(
                message: 'Clear all markers',
                child: FloatingActionButton(
                  onPressed: _clearMarkers,
                  heroTag: 'btn4',
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF0A4DA2),
                  elevation: 4,
                  child: const Icon(Icons.delete_outline),
                ),
              ),
            ],
          ),
        ),

        // Panel deslizable para mostrar la oficina más cercana
        if (_showOfficePanel && _nearestOffice != null) _buildOfficePanel(),
      ],
    );
  }

  // Construye el panel deslizable con la información de la oficina más cercana
  Widget _buildOfficePanel() {
    return DraggableScrollableSheet(
      initialChildSize: 0.25, // Tamaño inicial más pequeño (25% de la pantalla)
      minChildSize: 0.15, // Tamaño mínimo al que se puede reducir
      maxChildSize: 0.6, // Tamaño máximo al que se puede expandir
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 0),
            ],
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            physics: const ClampingScrollPhysics(),
            children: [
              // Indicador de arrastre
              Center(
                child: Container(
                  width: 60,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // Card para destacar el nombre de la oficina

              // Contenido del panel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Estado de la oficina - Mostrado de manera más prominente
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Open Now',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Closes at ${_nearestOffice!.closeHours}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    // Distancia a la oficina
                    const SizedBox(height: 8),
                    Text(
                      'Distance: ${_nearestOffice!.distanceInMiles.toStringAsFixed(2)} miles',
                      style: const TextStyle(
                        color: Color(0xFF0A4DA2),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Dirección principal - Ahora muestra la dirección real
                    if (_isLoadingAddress)
                      // Mostrar un indicador de carga mientras se obtiene la dirección
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    else
                      Text(
                        // Usar la dirección real obtenida de la API o la dirección del marcador
                        _formattedAddress ?? _nearestOffice!.address,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                    const SizedBox(height: 8),
                    // Información secundaria
                    Text(
                      _nearestOffice!.secondaryAddress,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),

                    // Dirección del usuario (marcador rojo)
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Your Location:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        // Botón para abrir Google Maps con la ubicación del usuario
                        IconButton(
                          onPressed: () {
                            _openGoogleMapsWithUserLocation();
                          },
                          icon: const Icon(
                            Icons.map,
                            color: Colors.red,
                          ),
                          tooltip: 'Open in Google Maps',
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (_isLoadingUserAddress)
                      // Mostrar un indicador de carga mientras se obtiene la dirección del usuario
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      )
                    else
                      Text(
                        _userFormattedAddress ??
                            'Location at ($_userLatitude, $_userLongitude)',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    const SizedBox(height: 4),
                    Text(
                      'Coordinates: ${_userLatitude.toStringAsFixed(6)}, ${_userLongitude.toStringAsFixed(6)}',
                      style: const TextStyle(fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),

                    // Botones de acción subidos más arriba
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          // Botón para llamar
                          ElevatedButton.icon(
                            onPressed: () {
                              // Acción para llamar a la oficina
                              launchUrl(Uri.parse('tel:+1234567890'));
                            },
                            icon: const Icon(
                              Icons.phone_in_talk_outlined,
                              color: Colors.white,
                            ),
                            label: const Text('Call Office'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A4DA2),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),

                          // Botón para obtener direcciones
                          OutlinedButton.icon(
                            onPressed: () {
                              // Acción para obtener direcciones
                              final url =
                                  'https://www.google.com/maps/dir/?api=1'
                                  '&origin=$_userLatitude,$_userLongitude'
                                  '&destination=${_nearestOffice!.latitude},${_nearestOffice!.longitude}';
                              launchUrl(Uri.parse(url));
                            },
                            icon: const Icon(
                              Icons.directions,
                              color: Color(0xFF0A4DA2),
                            ),
                            label: const Text(
                              'Get Directions',
                              style: TextStyle(color: Color(0xFF0A4DA2)),
                            ),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF0A4DA2)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Botón para cerrar el panel
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _showOfficePanel = false;
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.grey[700],
                        ),
                        child: const Text('Close'),
                      ),
                    ),

                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    // Asegurarse de liberar los recursos del controlador del mapa
    if (mapController != null) {
      debugPrint('Disposing GoogleMap controller');
      mapController!.dispose();
      mapController = null;
    }
    super.dispose();
  }
}
