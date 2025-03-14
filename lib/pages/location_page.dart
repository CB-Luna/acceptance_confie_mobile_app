import 'package:flutter/material.dart';

import '../utils/menu/circle_nav_bar.dart';
import '../widgets/homepage/header_section.dart';
import '../widgets/location/location_home_page.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: HeaderSection(),
          ),
          Expanded(
            child: LocationHomePage(),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -20),
        child: CircleNavBar(
          selectedPos: 2,
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
}
