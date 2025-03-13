import 'package:flutter/material.dart';

import '../utils/menu/circle_nav_bar.dart';
import '../widgets/homepage/header_section.dart';
import '../widgets/insproducts/insurance_card.dart';
import 'home_page.dart';

class AddInsurancePage extends StatefulWidget {
  const AddInsurancePage({super.key});

  @override
  State<AddInsurancePage> createState() => _AddInsurancePageState();
}

class _AddInsurancePageState extends State<AddInsurancePage> {
  int _selectedIndex = 1; // Inicializado en 1 para 'Add Insurance'

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FCFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(73),
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: HeaderSection(),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Center(
                    child: Text(
                      'More Ways to Get Covered',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InsuranceCard(
              title: 'Vehicle Insurance',
              imagePath: 'assets/products/4.0x/vehicle.png',
              route: '/vehicle-insurance',
              imageWidth: 220,
              imageHeight: 90,
            ),
            InsuranceCard(
              title: 'Property Insurance',
              imagePath: 'assets/products/4.0x/property.png',
              route: '/property-insurance',
              imageWidth: 150,
              imageHeight: 70,
            ),
            InsuranceCard(
              title: 'Personal Protection',
              imagePath: 'assets/products/4.0x/personal.png',
              route: '/personal-protection',
              imageWidth: 152,
              imageHeight: 65,
            ),
            InsuranceCard(
              title: 'Business Insurance',
              imagePath: 'assets/products/4.0x/business.png',
              route: '/business-insurance',
              imageWidth: 160,
              imageHeight: 60,
            ),
            InsuranceCard(
              title: 'Additional Products',
              imagePath: 'assets/products/4.0x/additional.png',
              route: '/additional-products',
              imageWidth: 139,
              imageHeight: 60,
            ),
            InsuranceCard(
              title: 'Ancillary Products',
              imagePath: 'assets/products/4.0x/ancillary.png',
              route: '/ancillary-products',
              imageWidth: 69,
              imageHeight: 60,
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -15),
        child: CircleNavBar(
          selectedPos: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0: // My Products
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
                break;
              case 2: // Location
                // TODO: Implementar navegación a Location
                break;
            }
          },
          tabItems: [
            TabData(Icons.home_outlined, 'My Products'),
            TabData(Icons.verified_user_outlined, 'Add Insurance'),
            TabData(Icons.location_on_outlined, 'Location'),
          ],
        ),
      ),
    );
  }
}
