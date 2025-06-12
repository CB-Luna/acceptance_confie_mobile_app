import 'package:flutter/material.dart';
import 'package:freeway_app/locatordevice/locator_device_module.dart';
import 'package:freeway_app/pages/add_insurance.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../models/quote_plan.dart';
import '../../../utils/menu/circle_nav_bar.dart';
import 'quote_plans_card.dart';

class QuotePlansPage extends StatefulWidget {
  const QuotePlansPage({super.key});

  @override
  State<QuotePlansPage> createState() => _QuotePlansPageState();
}

class _QuotePlansPageState extends State<QuotePlansPage> {
  bool _isMonthly = true;
  int _selectedIndex = 0;
  int? _selectedPlanIndex;

  final List<QuotePlan> _plans = [
    QuotePlan(
      title: 'singlePlan',
      iconPath: 'assets/products/vehicle/auto.svg',
      monthlyPrice: 12.0,
      annualPrice: 99.0,
      isPopular: true,
      primaryColor: AppTheme.primaryColor,
      accentColor: AppTheme.primaryColor,
      features: [
        PlanFeature(
          title: 'onePerson',
          iconPath: 'assets/icons/person.svg',
        ),
        PlanFeature(
          title: 'unlimitedUsage',
          subtitle: 'usagePeriod',
          iconPath: 'assets/icons/unlimited.svg',
        ),
        PlanFeature(
          title: 'nationwideCoverage',
          iconPath: 'assets/icons/coverage.svg',
        ),
        PlanFeature(
          title: 'lightDutyVehicle',
          iconPath: 'assets/icons/vehicle.svg',
        ),
      ],
    ),
    QuotePlan(
      title: 'familyPlan',
      iconPath: 'assets/products/vehicle/auto.svg',
      monthlyPrice: 17.0,
      annualPrice: 149.0,
      isPopular: false,
      primaryColor: AppTheme.tertiaryColor,
      accentColor: AppTheme.tertiaryColor,
      features: [
        PlanFeature(
          title: 'onePerson',
          iconPath: 'assets/icons/person.svg',
        ),
        PlanFeature(
          title: 'unlimitedUsage',
          subtitle: 'usagePeriod',
          iconPath: 'assets/icons/unlimited.svg',
        ),
        PlanFeature(
          title: 'nationwideCoverage',
          iconPath: 'assets/icons/coverage.svg',
        ),
        PlanFeature(
          title: 'lightDutyVehicle',
          iconPath: 'assets/icons/vehicle.svg',
        ),
      ],
    ),
    // Aquí puedes agregar más planes
  ];

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              context.translate('quotePlans.back'),
              style: const TextStyle(
                color: AppTheme.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 8),
            Text(
              context.translate('quotePlans.title'),
              style: TextStyle(
                color: AppTheme.getTitleTextColor(context),
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.translate('quotePlans.selectPlan'),
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w600,
                color: AppTheme.getPrimaryColor(context),
              ),
            ),
            Text(
              context.translate('quotePlans.selectPlanSubtitle'),
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w400,
                color: AppTheme.getTextGreyColor(context),
              ),
            ),
            const SizedBox(height: 30),
            _buildPlanTypeToggle(),
            const SizedBox(height: 40),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _plans
                    .asMap()
                    .entries
                    .map(
                      (entry) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: QuotePlanCard(
                          plan: entry.value,
                          onRequestQuote: () => _onRequestQuote(entry.value),
                          isSelected: _selectedPlanIndex == entry.key,
                          isMonthly: _isMonthly,
                        ),
                      ),
                    )
                    .toList(),
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
            TabData(
              Icons.home_outlined,
              context.translate('home.navigation.myProducts'),
            ),
            TabData(
              Icons.verified_user_outlined,
              context.translate('home.navigation.addInsurance'),
            ),
            TabData(
              Icons.location_on_outlined,
              context.translate('home.navigation.location'),
            ),
          ],
        ),
      ),
    );
  }

  void _onRequestQuote(QuotePlan plan) {
    setState(() {
      _selectedPlanIndex = _plans.indexOf(plan);
    });
    // Implementar la lógica para solicitar cotización
  }

  Widget _buildPlanTypeToggle() {
    return Container(
      width: 318,
      height: 80,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: ToggleSwitch(
          minWidth: 150.0,
          cornerRadius: 30.0,
          activeBgColors: [
            [AppTheme.getBlueColor(context)],
            [AppTheme.getBlueColor(context)],
          ],
          activeFgColor: AppTheme.white,
          inactiveBgColor: AppTheme.getCardColor(context),
          inactiveFgColor: AppTheme.getSubtitleTextColor(context),
          initialLabelIndex: _isMonthly ? 0 : 1,
          totalSwitches: 2,
          customWidgets: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.translate('quotePlans.monthly'),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                    color: _isMonthly
                        ? AppTheme.white
                        : AppTheme.getSubtitleTextColor(context),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.check_circle,
                  size: 20,
                  color: _isMonthly ? AppTheme.white : Colors.transparent,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  context.translate('quotePlans.annually'),
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.bold,
                    color: !_isMonthly
                        ? AppTheme.white
                        : AppTheme.getSubtitleTextColor(context),
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.check_circle,
                  size: 20,
                  color: !_isMonthly ? AppTheme.white : Colors.transparent,
                ),
              ],
            ),
          ],
          radiusStyle: true,
          animate: true,
          animationDuration: 200,
          onToggle: (index) {
            setState(() {
              _isMonthly = index == 0;
            });
          },
        ),
      ),
    );
  }
}
