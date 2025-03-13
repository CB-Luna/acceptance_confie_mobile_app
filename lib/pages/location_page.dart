import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/office_location.dart';
import '../services/location_service.dart';
import '../utils/menu/circle_nav_bar.dart';
import '../widgets/homepage/header_section.dart';
import '../widgets/location/app/ui/pages/map_page.dart';
import '../widgets/location/location_details_view.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  @override
  void initState() {
    super.initState();
    // Iniciar la búsqueda de ubicación al cargar la página
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationService>().getCurrentLocation();

      // Navegar directamente a la página del mapa en lugar de la pantalla de selección
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MapPage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header con margen superior de 20px
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: HeaderSection(),
          ),

          // Contenido principal
          Expanded(
            child: Consumer<LocationService>(
              builder: (context, locationService, child) {
                if (locationService.status == LocationStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (locationService.status == LocationStatus.success) {
                  return LocationDetailsView(
                    office: locationService.nearbyOffices.first,
                    allOffices: locationService.nearbyOffices,
                  );
                } else {
                  // Por defecto, mostrar la vista de detalles con datos de ejemplo
                  return LocationDetailsView(
                    office: locationService.nearbyOffices.isEmpty
                        ? _getExampleOffice()
                        : locationService.nearbyOffices.first,
                    allOffices: locationService.nearbyOffices.isEmpty
                        ? [_getExampleOffice()]
                        : locationService.nearbyOffices,
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -20), // Subir el menú 20px
        child: CircleNavBar(
          selectedPos: 2, // Índice para la ubicación
          onTap: (index) {
            if (index == 0) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (index == 1) {
              Navigator.pushReplacementNamed(context, '/add-insurance');
            }
          },
          tabItems: [
            TabData(Icons.home_outlined, 'My Products'),
            TabData(Icons.verified_user_outlined, '+ Add Insurance'),
            TabData(Icons.location_on_outlined, 'Location'),
          ],
        ),
      ),
    );
  }

  // Datos de ejemplo para mostrar cuando no hay datos reales
  OfficeLocation _getExampleOffice() {
    return OfficeLocation(
      id: '1',
      name: 'Freeway Insurance',
      address: '7400 Main St. Los Angeles CA 90020',
      secondaryAddress: '401 South Vermont #15',
      reference: '5th st / Vermont',
      latitude: 34.0522,
      longitude: -118.2437,
      openHours: '9am',
      closeHours: '7pm',
      rating: 4.5,
      distanceInMiles: 0.77,
      isOpen: true,
    );
  }
}
