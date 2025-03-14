import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_sorted_offices.dart';

// Simple implementation to avoid adding a state management package dependency
class LocationBloc {
  final GetCurrentLocation _getCurrentLocation;
  final GetSortedOffices _getSortedOffices;

  // Stream controllers for location states
  final _locationController = StreamController<Position>.broadcast();
  Stream<Position> get locationStream => _locationController.stream;

  final _officesController =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  Stream<List<Map<String, dynamic>>> get officesStream =>
      _officesController.stream;

  final _errorController = StreamController<String>.broadcast();
  Stream<String> get errorStream => _errorController.stream;

  LocationBloc(this._getCurrentLocation, this._getSortedOffices);

  Future<void> loadCurrentLocation() async {
    try {
      debugPrint('LocationBloc: Loading current location');
      final position = await _getCurrentLocation.execute();
      _locationController.add(position);
    } catch (e) {
      debugPrint('LocationBloc: Error loading location: $e');
      _errorController.add(e.toString());
    }
  }

  Future<void> loadNearbyOffices() async {
    try {
      debugPrint('LocationBloc: Loading nearby offices');
      final offices = await _getSortedOffices.execute();
      _officesController.add(offices);
    } catch (e) {
      debugPrint('LocationBloc: Error loading offices: $e');
      _errorController.add(e.toString());
    }
  }

  void dispose() {
    _locationController.close();
    _officesController.close();
    _errorController.close();
  }
}
