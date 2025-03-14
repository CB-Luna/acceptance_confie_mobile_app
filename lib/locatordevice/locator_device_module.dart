import 'package:flutter/material.dart';

import 'di/injection_container.dart' as di;
import 'domain/usecases/get_current_location.dart';
import 'domain/usecases/get_sorted_offices.dart';
import 'presentation/pages/location_details_view.dart';

/// Main entry point for the Locator Device module
class LocatorDeviceModule {
  static bool _initialized = false;

  /// Navigates to the Location Details view
  ///
  /// This method should be called from the menu when the location option is selected
  static Future<void> navigateToLocationView(BuildContext context) async {
    // Store the current context navigator before async operations
    final navigator = Navigator.of(context);

    // Initialize dependencies if not already done
    if (!_initialized) {
      await di.init();
      _initialized = true;
    }

    // Check if the context is still valid before navigating
    if (!context.mounted) return;

    // Navigate to the location view with required dependencies
    await navigator.push(
      MaterialPageRoute(
        settings: RouteSettings(
          arguments: {
            'getCurrentLocation': di.sl.get<GetCurrentLocation>(),
            'getSortedOffices': di.sl.get<GetSortedOffices>(),
          },
        ),
        builder: (context) => const LocationDetailsView(),
      ),
    );
  }
}
