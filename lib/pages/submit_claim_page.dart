import 'package:flutter/material.dart';

import '../utils/menu/circle_nav_bar.dart';
import '../widgets/submitclaim/bluefire_claim_card.dart';
import '../widgets/submitclaim/header_submitclaim.dart';
import '../widgets/submitclaim/safety_check_card.dart';

class SubmitClaimPage extends StatefulWidget {
  const SubmitClaimPage({super.key});

  @override
  State<SubmitClaimPage> createState() => _SubmitClaimPageState();
}

class _SubmitClaimPageState extends State<SubmitClaimPage> {
  int _selectedIndex = -1;
  bool _showBluefireCard = false;

  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0: // My Products
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1: // Add Insurance
        // TODO: Navigate to Add Insurance
        break;
      case 2: // Location
        // TODO: Navigate to Location
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5FCFF),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                const SubmitClaimHeader(),
                Expanded(
                  child: Container(
                    color: const Color(0xFFF5FCFF),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 103,
              left: 0,
              right: 0,
              child: Center(
                child: _showBluefireCard
                    ? const BluefireClaimCard()
                    : SafetyCheckCard(
                        onSafetyConfirmed: () {
                          setState(() {
                            _showBluefireCard = true;
                          });
                        },
                      ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CircleNavBar(
                selectedPos: _selectedIndex,
                onTap: _handleNavigation,
                tabItems: [
                  TabData(Icons.home, 'My Products'),
                  TabData(Icons.verified_user, '+ Add Insurance'),
                  TabData(Icons.location_on, 'Location'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
