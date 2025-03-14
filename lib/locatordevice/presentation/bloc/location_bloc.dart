import 'dart:async';

// Remove the unused import
// import '../../domain/entities/location.dart';
import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_sorted_offices.dart';
import 'location_event.dart';
import 'location_state.dart';

// Simple Emitter class to replace the one from flutter_bloc
typedef Emitter<S> = void Function(S state);

// Basic BLoC implementation without using flutter_bloc
abstract class Bloc<E, S> {
  final _stateController = StreamController<S>.broadcast();

  S _state;
  S get state => _state;
  Stream<S> get stream => _stateController.stream;

  Bloc(this._state) {
    _stateController.add(_state);
  }

  void emit(S state) {
    _state = state;
    if (!_stateController.isClosed) {
      _stateController.add(state);
    }
  }

  void close() {
    _stateController.close();
  }
}

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetCurrentLocation getCurrentLocation;
  final GetSortedOffices getSortedOffices;
  final _eventController = StreamController<LocationEvent>();

  LocationBloc({
    required this.getCurrentLocation,
    required this.getSortedOffices,
  }) : super(LocationInitial()) {
    _eventController.stream.listen(_mapEventToState);
  }

  void add(LocationEvent event) {
    if (!_eventController.isClosed) {
      _eventController.add(event);
    }
  }

  @override
  void close() {
    _eventController.close();
    super.close();
  }

  void _mapEventToState(LocationEvent event) async {
    if (event is LoadUserLocation) {
      await _onLoadUserLocation(event);
    } else if (event is LoadOffices) {
      await _onLoadOffices(event);
    }
  }

  Future<void> _onLoadUserLocation(LoadUserLocation event) async {
    emit(LocationLoading());
    try {
      final location = await getCurrentLocation();
      if (location != null) {
        emit(LocationLoaded(location));
      } else {
        emit(LocationError('Could not get current location'));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }

  Future<void> _onLoadOffices(LoadOffices event) async {
    try {
      if (state is LocationLoaded) {
        final currentLocation = (state as LocationLoaded).location;
        emit(LocationAndOfficesLoading(currentLocation));

        final offices = await getSortedOffices(currentLocation);
        emit(LocationAndOfficesLoaded(currentLocation, offices));
      } else {
        emit(LocationError('Location not loaded yet'));
      }
    } catch (e) {
      emit(LocationError(e.toString()));
    }
  }
}
