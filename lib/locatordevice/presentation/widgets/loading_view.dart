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
          Stack(
            alignment: Alignment.center,
            children: [
              // Círculo base blanco
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              // Animación de onda azul
              const SpinKitWaveSpinner(
                color: Color(0xFF0046B9),
                trackColor: Color(0xFF78BE00),
                waveColor: Color(0xFF78BE00),
                curve: Curves.decelerate,
                size: 60.0,
                duration: Duration(milliseconds: 1500),
              ),
              // Imagen del logo
              Image.asset(
                'assets/loading/freeway_logo.png',
                width: 35,
                height: 35,
                fit: BoxFit.contain,
              ),
            ],
          ),
          const SizedBox(height: 12),
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
