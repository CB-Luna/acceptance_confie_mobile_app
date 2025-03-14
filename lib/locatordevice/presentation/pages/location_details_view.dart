import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_sorted_offices.dart';

class LocationDetailsView extends StatefulWidget {
  const LocationDetailsView({super.key});

  @override
  State<LocationDetailsView> createState() => _LocationDetailsViewState();
}

class _LocationDetailsViewState extends State<LocationDetailsView> {
  late GetCurrentLocation _getCurrentLocation;
  late GetSortedOffices _getSortedOffices;

  Position? _currentPosition;
  List<Map<String, dynamic>> _offices = [];
  bool _isLoading = true;
  String? _errorMessage;

  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initDependencies();
    });
  }

  void _initDependencies() {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null) {
      setState(() {
        _errorMessage = 'Missing dependencies';
        _isLoading = false;
      });
      return;
    }

    _getCurrentLocation = args['getCurrentLocation'] as GetCurrentLocation;
    _getSortedOffices = args['getSortedOffices'] as GetSortedOffices;

    _loadLocationData();
  }

  Future<void> _loadLocationData() async {
    try {
      final position = await _getCurrentLocation.execute();
      setState(() {
        _currentPosition = position;
        _isLoading = false;
      });

      _updateMapPosition();
      await _loadOffices();
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not determine your location: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadOffices() async {
    try {
      final offices = await _getSortedOffices.execute();
      setState(() {
        _offices = offices;
      });

      _updateMarkers();
    } catch (e) {
      setState(() {
        _errorMessage = 'Could not load offices: $e';
      });
    }
  }

  void _updateMapPosition() {
    if (_currentPosition != null && _mapController != null) {
      final cameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14.0,
      );

      _mapController!
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position:
                LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
            infoWindow: const InfoWindow(title: 'Your Location'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        );
      });
    }
  }

  void _updateMarkers() {
    if (_mapController != null) {
      for (var i = 0; i < _offices.length; i++) {
        final office = _offices[i];
        final marker = Marker(
          markerId: MarkerId('office_$i'),
          position: LatLng(
            office['latitude'] as double,
            office['longitude'] as double,
          ),
          infoWindow: InfoWindow(
            title: office['name'] as String,
            snippet: office['address'] as String,
          ),
        );

        setState(() {
          _markers.add(marker);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Locations'),
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _loadLocationData();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          flex: 3,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _currentPosition != null
                  ? LatLng(
                      _currentPosition!.latitude,
                      _currentPosition!.longitude,
                    )
                  : const LatLng(0, 0),
              zoom: 14.0,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              _updateMapPosition();
              _updateMarkers();
            },
          ),
        ),
        Expanded(
          flex: 2,
          child: _offices.isEmpty
              ? const Center(child: Text('No nearby offices found'))
              : ListView.builder(
                  itemCount: _offices.length,
                  itemBuilder: (context, index) {
                    final office = _offices[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        child: Text('${index + 1}'),
                      ),
                      title: Text(office['name'] as String),
                      subtitle: Text(office['address'] as String),
                      trailing: IconButton(
                        icon: const Icon(Icons.directions),
                        onPressed: () {
                          // TODO: Add navigation to this location
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Navigation functionality coming soon',
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
