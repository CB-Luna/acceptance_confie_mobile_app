import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/locator_device_module.dart';
import 'package:freeway_app/pages/add_insurance.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

import '../../utils/menu/circle_nav_bar.dart';

class RequestCallPage extends StatefulWidget {
  const RequestCallPage({super.key});

  @override
  State<RequestCallPage> createState() => _RequestCallPageState();
}

class _RequestCallPageState extends State<RequestCallPage> {
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
                  'Help',
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
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              // Contenedor principal
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.getBackgroundColor(context),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Have questions or need assistance?\nWe're here to help!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppTheme.getTitleTextColor(context),
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Image.asset(
                          'assets/home/icons/contactagent.png',
                          width: 227.12,
                          height: 120,
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Customer Service',
                        style: TextStyle(
                          color: AppTheme.getSubtitleTextColor(context),
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Aquí irá la lógica para llamar al servicio al cliente
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.getPrimaryColor(context),
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_in_talk,
                              color: AppTheme.white,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Call (888) 443-4662',
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Insurance Quotes & Service',
                        style: TextStyle(
                          color: AppTheme.getSubtitleTextColor(context),
                          fontSize: 16,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () {
                          // Aquí irá la lógica para llamar a cotizaciones
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.getSecondaryColor(context),
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.phone_in_talk,
                              color: AppTheme.white,
                              size: 24,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Call (877) 753-7823',
                              style: TextStyle(
                                color: AppTheme.white,
                                fontSize: 16,
                                fontFamily: 'Open Sans',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
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
