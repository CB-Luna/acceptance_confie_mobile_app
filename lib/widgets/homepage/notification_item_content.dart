import 'dart:async';

import 'package:flutter/material.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../providers/notification_provider.dart';

/// Widget con estado para manejar la animación de eliminación de notificaciones
class NotificationItemContent extends StatefulWidget {
  final String policyNumber;
  final String title;
  final String location;
  final String date;
  final String time;
  final Color iconColor;
  final String notificationId;
  final bool isBlue;

  const NotificationItemContent({
    required this.policyNumber,
    required this.title,
    required this.location,
    required this.date,
    required this.time,
    required this.iconColor,
    required this.notificationId,
    required this.isBlue,
    super.key,
  });

  @override
  NotificationItemContentState createState() => NotificationItemContentState();
}

class NotificationItemContentState extends State<NotificationItemContent> {
  bool isDeleting = false;
  double progressValue = 0.0;
  late final animationDuration = const Duration(seconds: 3);
  DateTime? startTime;
  Timer? _animationTimer;

  @override
  void dispose() {
    // Cancelar cualquier timer pendiente al destruir el widget
    _animationTimer?.cancel();
    super.dispose();
  }

  // Función para iniciar la animación de eliminación
  void startDeleteAnimation() {
    // No iniciar si ya está en proceso de eliminación
    if (isDeleting) return;
    
    debugPrint('Iniciando animación de eliminación para notificación: ${widget.notificationId}');
    
    setState(() {
      isDeleting = true;
      progressValue = 0.0;
      startTime = DateTime.now();
    });

    // Usar un timer periódico para actualizar la animación
    _animationTimer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      _updateProgress();
    });
  }
  
  // Actualiza el progreso de la animación
  void _updateProgress() {
    if (!mounted || startTime == null) return;
    
    final elapsedTime = DateTime.now().difference(startTime!);
    final newProgressValue = elapsedTime.inMilliseconds / animationDuration.inMilliseconds;
    
    if (newProgressValue >= 1.0) {
      // Animación completa
      _animationTimer?.cancel();
      
      if (mounted) {
        setState(() {
          progressValue = 1.0;
        });
        
        // Usar un timer para asegurar que la UI se actualice antes de eliminar
        Timer(const Duration(milliseconds: 50), () {
          if (mounted) {
            debugPrint('Eliminando notificación: ${widget.notificationId}');
            Provider.of<NotificationProvider>(context, listen: false)
                .markAsRead(widget.notificationId);
          }
        });
      }
    } else {
      // Actualizar el progreso
      if (mounted) {
        setState(() {
          progressValue = newProgressValue;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: const EdgeInsets.only(bottom: 8),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // Contenido principal
            Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Círculo de color con icono (similar al estilo de ElegantNotification)
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: widget.isBlue
                          ? AppTheme.getBackgroundBlueColor(context)
                          : AppTheme.getBackgroundOrangeColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        widget.isBlue
                            ? Icons.info_outline
                            : Icons.chat_outlined,
                        color: widget.iconColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Contenido principal
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Número de póliza
                        Text(
                          widget.policyNumber,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 16 / 12,
                            letterSpacing: 0,
                            color: widget.iconColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Título
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            height: 16 / 14,
                            letterSpacing: 0,
                            color: widget.iconColor,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Detalles (ubicación, fecha, hora)
                        Text(
                          '${widget.location} | ${widget.date} | ${widget.time}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            height: 16 / 12,
                            letterSpacing: 0,
                            color: AppTheme.getTextGreyColor(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Botón para marcar como leída
                  GestureDetector(
                    onTap: isDeleting ? null : startDeleteAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: widget.iconColor, width: 1),
                      ),
                      child: Icon(
                        Icons.close,
                        color: widget.iconColor,
                        size: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Indicador de progreso (visible solo durante la eliminación)
            if (isDeleting)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: LinearProgressIndicator(
                  value: progressValue,
                  backgroundColor: Colors.transparent,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.isBlue
                        ? AppTheme.getBlueColor(context)
                        : AppTheme.getOrangeColor(context),
                  ),
                  minHeight: 2,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
