import 'package:flutter/material.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

class BillingInfoCard extends StatelessWidget {
  final String name;
  final String address;
  final String total;

  const BillingInfoCard({
    required this.name,
    required this.address,
    required this.total,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 323,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getBoxShadowColor(context),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 0,
                    child: Text(
                      context.translate('payment.billingAddress'),
                      style: TextStyle(
                        color: AppTheme.getPrimaryColor(context),
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            color: AppTheme.getTitleTextColor(context),
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          address,
                          style: TextStyle(
                            color: AppTheme.getSubtitleTextColor(context),
                            fontSize: 16,
                            fontFamily: 'Open Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: AppTheme.getDetailsGreyColor(context),
              thickness: 1,
              height: 1,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.translate('payment.paymentTotal'),
                  style: TextStyle(
                    color: AppTheme.getOrangeColor(context),
                    fontSize: 16,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w600,
                    height: 24 / 16,
                  ),
                ),
                Text(
                  total,
                  style: TextStyle(
                    color: AppTheme.getOrangeColor(context),
                    fontSize: 20,
                    fontFamily: 'Open Sans',
                    fontWeight: FontWeight.w700,
                    height: 18 / 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
