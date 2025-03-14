import 'package:flutter/foundation.dart';

import '../data/datasources/location_data_source.dart';
import '../data/repositories/location_repository_impl.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/usecases/get_current_location.dart';
import '../domain/usecases/get_sorted_offices.dart';

/// Simple service locator without external dependencies
class ServiceLocator {
  static final ServiceLocator _instance = ServiceLocator._internal();
  factory ServiceLocator() => _instance;
  ServiceLocator._internal();

  final Map<Type, Object> _dependencies = {};
  
  /// Register a dependency
  void registerSingleton<T extends Object>(T instance) {
    _dependencies[T] = instance;
  }
  
  /// Get a registered dependency
  T get<T extends Object>() {
    final instance = _dependencies[T];
    if (instance == null) {
      throw Exception('Type $T not registered in service locator');
    }
    return instance as T;
  }
  
  /// Check if a dependency is registered
  bool isRegistered<T extends Object>() {
    return _dependencies.containsKey(T);
  }
}

// Use our custom service locator
final sl = ServiceLocator();

/// Initializes dependencies for the LocatorDevice module
Future<void> init() async {
  debugPrint('Initializing Locator Device dependencies...');

  try {
    // Create instances in the correct order
    final locationDataSource = LocationDataSourceImpl();
    sl.registerSingleton<LocationDataSource>(locationDataSource);
    debugPrint('Registered LocationDataSource');
    
    final locationRepository = LocationRepositoryImpl(locationDataSource: locationDataSource);
    sl.registerSingleton<LocationRepository>(locationRepository);
    debugPrint('Registered LocationRepository');
    
    final getCurrentLocation = GetCurrentLocation(locationRepository);
    sl.registerSingleton<GetCurrentLocation>(getCurrentLocation);
    debugPrint('Registered GetCurrentLocation');
    
    final getSortedOffices = GetSortedOffices(locationRepository);
    sl.registerSingleton<GetSortedOffices>(getSortedOffices);
    debugPrint('Registered GetSortedOffices');

    debugPrint('All dependencies registered successfully');
  } catch (e) {
    debugPrint('Error registering dependencies: $e');
    rethrow; // Re-throw to be caught by the caller
  }
}
