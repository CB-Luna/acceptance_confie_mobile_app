import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  final String message;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Color? textColor;

  const LoadingView({
    super.key,
    this.message = 'Cargando...',
    this.backgroundColor,
    this.indicatorColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitWaveSpinner(
            color: indicatorColor ?? const Color(0xFF0046B9),
            trackColor: const Color(0xFF78BE00),
            waveColor: const Color(0xFF0046B9),
            curve: Curves.decelerate,
            size: 60.0,
            duration: const Duration(milliseconds: 1200),
          ),
          const SizedBox(height: 16),
          if (message.isNotEmpty)
            Material(
              color: Colors.transparent,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  message,
                  style: TextStyle(
                    color: textColor ?? Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Muestra un overlay con un indicador de carga
  ///
  /// Retorna un OverlayEntry que debe ser removido cuando se complete la operación
  ///
  /// Ejemplo de uso:
  /// ```dart
  /// final overlay = LoadingView.showOverlay(context, message: 'Cargando...');
  /// // ... realizar operación ...
  /// overlay.remove(); // Remover el overlay cuando termine
  /// ```
  static OverlayEntry showOverlay(
    BuildContext context, {
    String message = 'Cargando...',
    Color overlayColor = Colors.black54,
    Color? indicatorColor = Colors.blue,
    Color? backgroundColor,
    Color? textColor = Colors.white,
  }) {
    final overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: overlayColor,
        child: LoadingView(
          message: message,
          backgroundColor: backgroundColor,
          indicatorColor: indicatorColor,
          textColor: textColor,
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
  }
}
