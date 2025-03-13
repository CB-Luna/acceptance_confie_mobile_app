import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Widget que encapsula el GoogleMap para simplificar su integración
class GoogleMapView extends StatelessWidget {
  final Function(GoogleMapController) onMapCreated;
  final CameraPosition initialPosition;
  final Set<Marker> markers;
  final Function(LatLng) onTap;

  const GoogleMapView({
    super.key,
    required this.onMapCreated,
    required this.initialPosition,
    required this.markers,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: onMapCreated,
      initialCameraPosition: initialPosition,
      markers: markers,
      onTap: onTap,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: true,
      mapToolbarEnabled: false,
    );
  }
}
