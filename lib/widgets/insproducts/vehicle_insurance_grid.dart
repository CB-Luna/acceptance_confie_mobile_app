import 'package:flutter/material.dart';
import 'package:freeway_app/widgets/insproducts/motorcycle_insurance_page.dart'
    show MotorcycleInsurancePage;
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/services/location_service.dart';
import '../../pages/home_page.dart';
import '../../utils/menu/circle_nav_bar.dart';
import '../../widgets/common/custom_dialog.dart';
import 'zip_code_dialog.dart';

class VehicleInsuranceGrid extends StatefulWidget {
  const VehicleInsuranceGrid({super.key});

  @override
  State<VehicleInsuranceGrid> createState() => _VehicleInsuranceGridState();
}

class _VehicleInsuranceGridState extends State<VehicleInsuranceGrid> {
  final LocationService _locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FCFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5FCFF),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF0046B9),
                  size: 20,
                ),
                Text(
                  'Back',
                  style: TextStyle(
                    color: Color(0xFF0046B9),
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 100,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Select a product to start your quote',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: [
                  _buildInsuranceItem(context, 'Auto', 'auto'),
                  _buildInsuranceItem(context, 'Motorcycle', 'motorcycle'),
                  _buildInsuranceItem(context, 'Motorhome', 'motorhome'),
                  _buildInsuranceItem(context, 'RV/\nMotorhome', 'motorhome'),
                  _buildInsuranceItem(context, 'ATV', 'atv'),
                  _buildInsuranceItem(context, 'Snowmobile', 'snowmobile'),
                  _buildInsuranceItem(context, 'SR-22\nInsurance', 'SR-22'),
                  _buildInsuranceItem(context, 'Classic Car', 'Classi-Car'),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: CircleNavBar(
          selectedPos: 1,
          tabItems: [
            TabData(Icons.home_outlined, 'My Products'),
            TabData(Icons.verified_user_outlined, '+ Add Insurance'),
            TabData(Icons.location_on_outlined, 'Location'),
          ],
          onTap: (index) {
            switch (index) {
              case 0: // My Products
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                break;
              case 1: // Add Insurance
                // Ya estamos en Add Insurance
                break;
              case 2: // Location
                // TODO: Implementar navegación a Location
                break;
            }
          },
        ),
      ),
    );
  }

  Widget _buildInsuranceItem(
    BuildContext context,
    String title,
    String iconName,
  ) {
    return GestureDetector(
      onTap: () {
        switch (title) {
          case 'Auto':
            _handleAutoInsurance(context);
            break;
          case 'Motorcycle':
            _showMotorcycleDialog(context);
            break;
          // TODO: Implementar navegación para otros tipos de seguro
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/products/vehiclepng/4.0x/$iconName.png',
              height: 40,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para manejar el seguro de auto con geolocalización
  Future<void> _handleAutoInsurance(BuildContext context) async {
    try {
      // Verificar si los servicios de ubicación están habilitados
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Si los servicios de ubicación no están habilitados, mostrar diálogo sin código postal
        if (!context.mounted) return;
        await _showZipCodeDialog(context, null);
        return;
      }

      // Verificar permisos de ubicación
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Si los permisos son denegados, mostrar diálogo sin código postal
          if (!context.mounted) return;
          await _showZipCodeDialog(context, null);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Si los permisos están denegados permanentemente, mostrar diálogo sin código postal
        if (!context.mounted) return;
        await _showZipCodeDialog(context, null);
        return;
      }

      // Obtener la posición actual
      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Realizar reverse geocoding para obtener el código postal
      final String? zipCode = await _locationService.getZipCodeFromCoordinates(
        position.latitude,
        position.longitude,
      );

      // Mostrar el diálogo con el código postal obtenido
      if (!context.mounted) return;
      await _showZipCodeDialog(context, zipCode);
    } catch (e) {
      debugPrint('Error al obtener la ubicación: $e');
      // En caso de error, mostrar diálogo sin código postal
      if (!context.mounted) return;
      await _showZipCodeDialog(context, null);
    }
  }

  // Método para mostrar el diálogo de código postal
  Future<void> _showZipCodeDialog(
    BuildContext context,
    String? initialZipCode,
  ) async {
    final String? zipCode = await ZipCodeDialog.show(
      context: context,
      initialZipCode: initialZipCode,
    );

    if (zipCode != null && context.mounted) {
      // Validar el código postal con la API de Zippopotam
      final placeInfo = await _locationService.validateZipCode(zipCode);

      if (placeInfo != null && context.mounted) {
        // Si el código postal es válido, mostrar el diálogo de página web
        await _showWebPageDialog(
          context,
          zipCode,
          placeInfo['placeName'],
          placeInfo['stateAbbreviation'],
        );
      } else if (context.mounted) {
        // Si el código postal no es válido, mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid ZIP code. Please try again.')),
        );
      }
    }
  }

  // Método para mostrar el diálogo de página web
  Future<void> _showWebPageDialog(
    BuildContext context,
    String zipCode,
    String placeName,
    String stateAbbreviation,
  ) async {
    final bool? result = await CustomDialog.show(
      context: context,
      title: 'Continue to Auto Insurance Quote',
      content:
          'You are about to get a quote for auto insurance in $placeName, $stateAbbreviation ($zipCode). Would you like to proceed?',
      confirmText: 'Continue',
      cancelText: 'Cancel',
      onConfirm: () async {
        // Abrir la URL en el navegador
        final Uri url = Uri.parse(
            'https://triton.freeway.com/?media_code=FWYCA-A-WW-WS-E-05884&phone=877-699-2436&zip_code=$zipCode&city=$placeName&state=$stateAbbreviation&system=atalaya');
        try {
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.inAppWebView);
          } else {
            // Si no se puede abrir en modo inAppWebView, intentar con el navegador externo
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        } catch (e) {
          // Mostrar un mensaje de error si no se puede abrir la URL
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content:
                    Text('Could not open the website. Please try again later.'),
                duration: Duration(seconds: 3),
              ),
            );
          }
        }
      },
    );
  }

  // Método para mostrar el diálogo de motocicleta
  Future<void> _showMotorcycleDialog(BuildContext context) async {
    final bool? result = await CustomDialog.show(
      context: context,
      title: 'Motorcycle Insurance',
      content:
          'You\'re about to get a quote for motorcycle insurance. Would you like to proceed?',
      confirmText: 'Get Quote',
      cancelText: 'Not Now',
      onConfirm: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MotorcycleInsurancePage(),
          ),
        );
      },
    );
  }
}
