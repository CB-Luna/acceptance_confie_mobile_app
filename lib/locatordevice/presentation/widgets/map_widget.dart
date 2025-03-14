import 'package:flutter/material.dart';

import '../../domain/entities/location.dart';
import '../../domain/entities/office.dart';

class MapWidget extends StatelessWidget {
  final Location location;
  final List<Office>? offices;

  const MapWidget({
    required this.location,
    super.key,
    this.offices,
  });

  @override
  Widget build(BuildContext context) {
    // Here you would implement a proper map view with location and office markers
    // For now, we'll use a placeholder that shows location details
    return Container(
      color: Colors.grey[200],
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.map, size: 60, color: Colors.blue),
            const SizedBox(height: 16),
            Text(
              'Tu ubicación actual',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Latitud: ${location.latitude.toStringAsFixed(6)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              'Longitud: ${location.longitude.toStringAsFixed(6)}',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (offices != null && offices!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                '${offices!.length} oficinas encontradas',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Oficina más cercana: ${offices!.first.name}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Distancia: ${(offices!.first.distance! / 1000).toStringAsFixed(2)} km',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
