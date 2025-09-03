import 'package:acceptance_app/utils/app_localizations_extension.dart';
import 'package:acceptance_app/utils/responsive_font_sizes.dart';
import 'package:acceptance_app/widgets/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BluefireClaimCard extends StatelessWidget {
  const BluefireClaimCard({super.key});

  void _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.8,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getBoxShadowColor(context),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/products/vehiclepng/4.0x/Bluefire.png',
            height: width * 0.1,
          ),
          const SizedBox(height: 16),
          Text(
            context.translate('submitClaim.bluefireClaim.title'),
            style: TextStyle(
              color: AppTheme.getPrimaryColor(context),
              fontSize: responsiveFontSizes.titleSmall(context),
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            context.translate('submitClaim.bluefireClaim.instructions'),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.getTitleTextColor(context),
              fontSize: responsiveFontSizes.bodyMedium(context),
              fontFamily: 'Lato',
              fontWeight: FontWeight.w600,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 16),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context
                      .translate('submitClaim.bluefireClaim.cnmPolicyPrefix'),
                  style: TextStyle(
                    color: AppTheme.getTextGreyColor(context),
                    fontSize: responsiveFontSizes.bodyMedium(context),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => _launchPhone('8332863057'),
                    child: Text(
                      '(833) 286-3057',
                      style: TextStyle(
                        color: AppTheme.getPrimaryColor(context),
                        fontSize: responsiveFontSizes.bodySmall(context),
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: context
                      .translate('submitClaim.bluefireClaim.gspPolicyPrefix'),
                  style: TextStyle(
                    color: AppTheme.getTextGreyColor(context),
                    fontSize: responsiveFontSizes.bodyMedium(context),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () => _launchPhone('8004683466'),
                    child: Text(
                      '(800) 468-3466',
                      style: TextStyle(
                        color: AppTheme.getPrimaryColor(context),
                        fontSize: responsiveFontSizes.bodySmall(context),
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          Wrap(
            children: [
              SizedBox(
                width: 18,
                height: 25,
                child: Checkbox(
                  value: false,
                  onChanged: (value) {
                    // TODO: Implement checkbox state
                  },
                  activeColor: AppTheme.getPrimaryColor(context),
                  side: BorderSide(
                    color: AppTheme.getPrimaryColor(context),
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                context.translate(
                  'submitClaim.bluefireClaim.policyholderConfirmation',
                ),
                style: TextStyle(
                  color: AppTheme.getTextGreyColor(context),
                  fontSize: responsiveFontSizes.bodyMedium(context),
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            context.translate(
              'submitClaim.bluefireClaim.policyNumberInstructions',
            ),
            style: TextStyle(
              color: AppTheme.getTitleTextColor(context),
              fontSize: responsiveFontSizes.bodySmall(context),
              fontFamily: 'Lato',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement start claim
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.getPrimaryColor(context),
                foregroundColor: AppTheme.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                context.translate('submitClaim.bluefireClaim.startClaim'),
                style: TextStyle(
                  fontSize: responsiveFontSizes.bodyLarge(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
