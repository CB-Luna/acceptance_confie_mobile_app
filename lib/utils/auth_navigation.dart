import 'package:flutter/material.dart';
import '../pages/login_page.dart';

/// Utilidades para la navegación relacionada con la autenticación
class AuthNavigation {
  /// Navega a la pantalla de login y elimina todas las rutas anteriores
  static void navigateToLogin(BuildContext context) {
    // Navegar a la pantalla de login directamente
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (route) => false, // Elimina todas las rutas anteriores
    );
  }
}
