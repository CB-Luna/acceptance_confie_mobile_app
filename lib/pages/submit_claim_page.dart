import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/locator_device_module.dart';
import 'package:freeway_app/pages/add_insurance.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

import '../utils/menu/circle_nav_bar.dart';
import '../widgets/submitclaim/bluefire_claim_card.dart';
import '../widgets/submitclaim/safety_check_card.dart';

class SubmitClaimPage extends StatefulWidget {
  const SubmitClaimPage({super.key});

  @override
  State<SubmitClaimPage> createState() => _SubmitClaimPageState();
}

class _SubmitClaimPageState extends State<SubmitClaimPage> {
  int _selectedIndex = 0;
  bool _showBluefireCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppTheme.getBackgroundHeaderColor(context),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: AppTheme.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        leadingWidth: 56,
        title: const Stack(
          alignment: Alignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Submit a Claim',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              child: Text(
                'Back',
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
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
          ],
        ),
      ),
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, 0),
        child: CircleNavBar(
          selectedPos: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddInsurancePage(),
                  ),
                ).then((_) => setState(() => _selectedIndex = 0));
                break;
              case 2:
                LocatorDeviceModule.navigateToLocationView(context);
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
