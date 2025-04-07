import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/locator_device_module.dart';
import 'package:freeway_app/pages/add_insurance.dart';
import 'package:freeway_app/utils/menu/circle_nav_bar.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

class IdCardPage extends StatefulWidget {
  const IdCardPage({super.key});

  @override
  State<IdCardPage> createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.getBackgroundHeaderColor(context),
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
                  'ID Card',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 20,
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
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppTheme.getBackgroundColor(context),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 3),
              blurRadius: 8,
              spreadRadius: -1,
              color: AppTheme.getBoxShadowColor(context), // 0D is 13% opacity
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    left: 70,
                    child: Image.asset(
                      'assets/home/idcardicons/add_apple_wallet.png',
                      width: 146,
                      height: 45,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 30,
                    right: 50,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.download_outlined,
                            color: AppTheme.getIconColor(context),
                          ),
                          onPressed: () {
                            // TODO: Implement download functionality
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.print_outlined,
                            color: AppTheme.getIconColor(context),
                          ),
                          onPressed: () {
                            // TODO: Implement print functionality
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: (MediaQuery.of(context).size.width - 309) / 2,
                    child: Container(
                      width: 309,
                      height: 394,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.asset(
                          'assets/home/idcardicons/card_id.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top:
                        504, // 95 (card top) + 394 (card height) + 15 (spacing)
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Text(
                        'This is not proof of coverage (Legal to provide final text)',
                        style: TextStyle(
                          color: AppTheme.getTextGreyColor(context),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ],
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
