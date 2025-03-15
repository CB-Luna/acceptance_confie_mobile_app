import 'dart:io';

import 'package:geolocator/geolocator.dart';

class DeviceInfo {
  Future<bool> isEmulatorOrSimulator() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await Geolocator.getLastKnownPosition();
        // Las coordenadas 37.42, -122.08 son típicas de un emulador Android
        if (androidInfo != null &&
            (androidInfo.latitude - 37.42).abs() < 0.1 &&
            (androidInfo.longitude - (-122.08)).abs() < 0.1) {
          return true;
        }
      }
      // Implementar más lógica para iOS si es necesario
      return false;
    } catch (e) {
      return false;
    }
  }
}
