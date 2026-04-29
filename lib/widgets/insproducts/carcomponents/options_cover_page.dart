import 'package:acceptance_app/utils/menu/circle_nav_bar.dart';
import 'package:flutter/material.dart';

import 'options_cover_card.dart';

class OptionsCoverPage extends StatefulWidget {
  final int initialMenuIndex;

  const OptionsCoverPage({
    super.key,
    this.initialMenuIndex = 1, // Por defecto selecciona +Add Insurance
  });

  @override
  State<OptionsCoverPage> createState() => _OptionsCoverPageState();
}

class _OptionsCoverPageState extends State<OptionsCoverPage> {
  int _selectedNavIndex = 1;
  String? _selectedInsurance;

  final List<TabData> _navItems = [
    TabData(Icons.home, 'My Products'),
    TabData(Icons.verified_user, '+Add Insurance'),
    TabData(Icons.location_on, 'Location'),
  ];

  @override
  void initState() {
    super.initState();
    _selectedNavIndex = widget.initialMenuIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FCFF),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: CircleNavBar(
          tabItems: _navItems,
          selectedPos: _selectedNavIndex,
          onTap: (index) {
            setState(() {
              _selectedNavIndex = index;
            });
          },
        ),
      ),
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
                    fontFamily: 'Lato',
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/products/vehiclepng/4.0x/auto.png',
                          width: 40,
                          height: 40,
                          color: const Color(0xFF0046B9),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Auto Insurance',
                        style: TextStyle(
                          color: Color(0xFF0046B9),
                          fontSize: 20,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Center(
                    child: Text(
                      'Select your preferred coverage options',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Acceptance Insurance Card
            OptionsCoverCard(
              logoPath: 'assets/home/banners/insurance4.0x/logo-freeway.png',
              price: 83.00,
              onCoverageDetails: () {
                // Implementar vista de detalles
              },
              onContinue: () {
                setState(() {
                  _selectedInsurance = 'freeway';
                });
                // Implementar navegación
              },
              isSelected: _selectedInsurance == 'freeway',
            ),
            // Acceptance Insurance Card
            OptionsCoverCard(
              logoPath: 'assets/home/banners/insurance4.0x/logo_acceptance.png',
              price: 120.83,
              onCoverageDetails: () {
                // Implementar vista de detalles
              },
              onContinue: () {
                setState(() {
                  _selectedInsurance = 'acceptance';
                });
                // Implementar navegación
              },
              isSelected: _selectedInsurance == 'acceptance',
            ),
            // Bluefire Insurance Card
            OptionsCoverCard(
              logoPath: 'assets/home/banners/insurance4.0x/logo-bluefire.png',
              price: 146.99,
              onCoverageDetails: () {
                // Implementar vista de detalles
              },
              onContinue: () {
                setState(() {
                  _selectedInsurance = 'bluefire';
                });
                // Implementar navegación
              },
              isSelected: _selectedInsurance == 'bluefire',
            ),
            // Show more quotes button
            Center(
              child: TextButton.icon(
                onPressed: () {
                  // Implementar mostrar más cotizaciones
                },
                icon: const Icon(
                  Icons.add_circle_outline,
                  color: Color(0xFF0046B9),
                ),
                label: const Text(
                  'Show more quotes',
                  style: TextStyle(
                    color: Color(0xFF0046B9),
                    fontSize: 14,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
