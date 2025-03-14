import 'package:flutter/material.dart';

import '../../domain/usecases/get_current_location.dart';
import '../../domain/usecases/get_sorted_offices.dart';
import '../bloc/location_bloc.dart';
import '../bloc/location_event.dart';
import '../bloc/location_state.dart';
import '../widgets/location_bottom_sheet.dart';
import '../widgets/map_widget.dart';

class LocationDetailsView extends StatefulWidget {
  const LocationDetailsView({super.key});

  @override
  State<LocationDetailsView> createState() => _LocationDetailsViewState();
}

class _LocationDetailsViewState extends State<LocationDetailsView> {
  late LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    // Need to delay getting bloc until after widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _locationBloc = _getBlocFromContext();
      _locationBloc.add(LoadUserLocation());
    });
  }

  LocationBloc _getBlocFromContext() {
    // Extract dependencies from the arguments map
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return LocationBloc(
      getCurrentLocation: args['getCurrentLocation'] as GetCurrentLocation,
      getSortedOffices: args['getSortedOffices'] as GetSortedOffices,
    );
  }

  @override
  void dispose() {
    // Only close the bloc if it's been initialized
    if (mounted) {
      _locationBloc.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
      ),
      body: FutureBuilder<void>(
        future: Future.delayed(
            Duration.zero), // Ensure the build happens after initState
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          return StreamBuilder<LocationState>(
            stream: _locationBloc.stream,
            initialData: _locationBloc.state,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              final state = snapshot.data!;

              // Handle state changes similar to BlocListener
              if (state is LocationLoaded) {
                // When location is loaded, load offices
                _locationBloc.add(LoadOffices());
              }

              // Build UI based on current state
              if (state is LocationInitial || state is LocationLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LocationError) {
                return Center(child: Text('Error: ${state.message}'));
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: _buildMap(state),
                    ),
                    _buildBottomSheet(state),
                  ],
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildMap(LocationState state) {
    if (state is LocationLoaded || state is LocationAndOfficesLoading) {
      return MapWidget(location: (state as dynamic).location);
    } else if (state is LocationAndOfficesLoaded) {
      return MapWidget(
        location: state.location,
        offices: state.offices,
      );
    } else {
      return const Center(child: Text('No hay datos de ubicación disponibles'));
    }
  }

  Widget _buildBottomSheet(LocationState state) {
    return LocationBottomSheet(state: state);
  }
}
