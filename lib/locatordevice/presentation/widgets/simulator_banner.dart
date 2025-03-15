import 'package:flutter/material.dart';

class SimulatorBanner extends StatelessWidget {
  final VoidCallback onClose;

  const SimulatorBanner({
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.orange[100],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.orange),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Ubicación simulada - Este dispositivo es un emulador',
                  style: TextStyle(color: Colors.orange),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.orange),
                onPressed: onClose,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
