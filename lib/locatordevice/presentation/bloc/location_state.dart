import '../../domain/entities/location.dart';
import '../../domain/entities/office.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final Location location;

  LocationLoaded(this.location);
}

class LocationAndOfficesLoading extends LocationState {
  final Location location;

  LocationAndOfficesLoading(this.location);
}

class LocationAndOfficesLoaded extends LocationState {
  final Location location;
  final List<Office> offices;

  LocationAndOfficesLoaded(this.location, this.offices);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
