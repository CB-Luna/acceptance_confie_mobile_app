import 'package:flutter/material.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

class SafetyCheckCard extends StatelessWidget {
  final VoidCallback onSafetyConfirmed;

  const SafetyCheckCard({
    required this.onSafetyConfirmed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 256,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Are you safe?',
              style: TextStyle(
                color: AppTheme.getPrimaryColor(context),
                fontSize: 24,
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'If you need immediate help, please call 911.',
            style: TextStyle(
              color: AppTheme.getSubtitleTextColor(context),
              fontSize: 14,
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement call 911
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.getBackgroundOrangeColor(context),
                  foregroundColor: AppTheme.getOrangeColor(context),
                  side: BorderSide(color: AppTheme.getOrangeColor(context)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  'Call 911',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: onSafetyConfirmed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.getPrimaryColor(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: const Text(
                  "I'm Safe",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
