import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';

import '../data/services/biometric_service.dart';

class BiometricProvider extends ChangeNotifier {
  final BiometricService _biometricService = BiometricService();
  
  bool _isAvailable = false;
  bool _isEnabled = false;
  String _biometricType = 'Touch ID';
  bool _isLoading = true;

  bool get isAvailable => _isAvailable;
  bool get isEnabled => _isEnabled;
  String get biometricType => _biometricType;
  bool get isLoading => _isLoading;

  BiometricProvider() {
    _initBiometrics();
  }

  /// Inicializa el estado de la biometría
  Future<void> _initBiometrics() async {
    _isLoading = true;
    notifyListeners();

    // Verifica si el dispositivo soporta biometría
    _isAvailable = await _biometricService.isBiometricAvailable();
    
    if (_isAvailable) {
      // Obtiene el tipo de biometría disponible
      _biometricType = await _biometricService.getBiometricTypeName();
      
      // Verifica si la biometría está habilitada en la app
      _isEnabled = await _biometricService.isBiometricEnabled();
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Habilita o deshabilita la autenticación biométrica
  Future<bool> toggleBiometric(bool enabled) async {
    _isLoading = true;
    notifyListeners();

    // Si estamos habilitando la biometría, verificamos primero que funcione
    if (enabled) {
      // Usamos checkEnabled=false porque estamos en el proceso de habilitación
      final authenticated = await _biometricService.authenticate(checkEnabled: false);
      if (!authenticated) {
        _isLoading = false;
        notifyListeners();
        return false;
      }
    }

    // Guarda la preferencia
    final success = await _biometricService.setBiometricEnabled(enabled);
    if (success) {
      _isEnabled = enabled;
    }

    _isLoading = false;
    notifyListeners();
    return success;
  }

  /// Autentica al usuario usando biometría
  /// 
  /// Este método se usa para autenticar al usuario cuando la biometría ya está habilitada
  /// y se quiere usar para acceder a la aplicación.
  Future<bool> authenticate() async {
    // No es necesario verificar _isEnabled aquí porque ya lo hacemos en el servicio
    // y podría causar problemas si queremos autenticar durante el proceso de habilitación
    if (!_isAvailable) {
      return false;
    }

    // Llamamos al servicio con checkEnabled=true para que verifique si la biometría está habilitada
    return await _biometricService.authenticate(checkEnabled: true);
  }

  /// Verifica si la biometría está disponible y habilitada
  Future<void> refreshBiometricState() async {
    await _initBiometrics();
  }

  /// Obtiene los tipos de biometría disponibles
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _biometricService.getAvailableBiometrics();
  }
}
