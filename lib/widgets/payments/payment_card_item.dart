import 'package:flutter/material.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

class PaymentCardItem extends StatelessWidget {
  final String cardNumber;
  final String expiry;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const PaymentCardItem({
    required this.cardNumber,
    required this.expiry,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected ? AppTheme.getPrimaryColor(context) : AppTheme.white,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  imagePath,
                  width: 64,
                  height: 40,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cardNumber,
                      style: TextStyle(
                        color: AppTheme.getTitleTextColor(context),
                        fontSize: 16,
                        fontFamily: 'Open Sans',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      expiry,
                      style: TextStyle(
                        color: AppTheme.getSubtitleTextColor(context),
                        fontSize: 14,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Icon(
              isSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked,
              color: isSelected
                  ? AppTheme.getPrimaryColor(context)
                  : AppTheme.white,
            ),
          ],
        ),
      ),
    );
  }
}
