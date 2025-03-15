import 'package:flutter/material.dart';

class MapButtons extends StatelessWidget {
  final VoidCallback onLocationPressed;
  final VoidCallback onToggleListPressed;

  const MapButtons({
    required this.onLocationPressed,
    required this.onToggleListPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 16,
      bottom: 180,
      child: Column(
        children: [
          FloatingActionButton(
            heroTag: 'currentLocation',
            backgroundColor: Colors.white,
            onPressed: onLocationPressed,
            child: const Icon(Icons.my_location, color: Colors.blue),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            heroTag: 'toggleList',
            backgroundColor: Colors.white,
            onPressed: onToggleListPressed,
            child: const Icon(Icons.list, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
