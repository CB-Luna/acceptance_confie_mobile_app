import 'package:flutter/material.dart';

import '../../models/office_location.dart';
import 'app/ui/pages/map_page.dart';
import 'location_details_view.dart';

class LocationHomePage extends StatefulWidget {
  const LocationHomePage({super.key});

  @override
  State<LocationHomePage> createState() => _LocationHomePageState();
}

class _LocationHomePageState extends State<LocationHomePage> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _navigateToMap();
  }

  void _navigateToMap() {
    if (!_hasNavigated) {
      _hasNavigated = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MapPage(),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocationDetailsView(
      office: _getExampleOffice(),
      allOffices: [_getExampleOffice()],
    );
  }

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
