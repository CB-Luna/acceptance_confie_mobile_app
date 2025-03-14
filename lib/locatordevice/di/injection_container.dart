// Comment out the get_it import until the package is added
// import 'package:get_it/get_it.dart';

import '../data/datasources/location_datasource.dart';
import '../data/datasources/office_datasource.dart';
import '../data/repositories/location_repository_impl.dart';
import '../data/repositories/office_repository_impl.dart';
import '../domain/repositories/location_repository.dart';
import '../domain/repositories/office_repository.dart';
import '../domain/usecases/get_current_location.dart';
import '../domain/usecases/get_sorted_offices.dart';
import '../presentation/bloc/location_bloc.dart';

// Temporary Service Locator implementation until get_it is available
class ServiceLocator {
  static final ServiceLocator _singleton = ServiceLocator._internal();
  factory ServiceLocator() => _singleton;
  ServiceLocator._internal();

  final Map<String, dynamic> _instances = {};

  T get<T>() {
    return _instances[T.toString()] as T;
  }

  void registerFactory<T>(T Function() factory) {
    _instances[T.toString()] = factory();
  }

  void registerLazySingleton<T>(T Function() factory) {
    _instances[T.toString()] = factory();
  }
}

final sl = ServiceLocator();

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => LocationBloc(
      getCurrentLocation: sl.get<GetCurrentLocation>(),
      getSortedOffices: sl.get<GetSortedOffices>(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(
      () => GetCurrentLocation(sl.get<LocationRepository>()));
  sl.registerLazySingleton(() => GetSortedOffices(sl.get<OfficeRepository>()));

  // Repositories
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(sl.get<LocationDataSource>()),
  );
  sl.registerLazySingleton<OfficeRepository>(
    () => OfficeRepositoryImpl(
        sl.get<OfficeDataSource>(), sl.get<LocationRepository>()),
  );

  // Data sources
  sl.registerLazySingleton<LocationDataSource>(
    () => LocationDataSourceImpl(),
  );
  sl.registerLazySingleton<OfficeDataSource>(
    () => OfficeDataSourceImpl(),
  );
}
