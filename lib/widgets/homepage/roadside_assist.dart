import 'package:flutter/material.dart';
import 'package:freeway_app/data/models/auth/policy_model.dart';
import 'package:freeway_app/utils/responsive_font_sizes.dart';

import '../../widgets/theme/app_theme.dart';

class RoadsideAssist extends StatelessWidget {
  final String policyNumber;
  final PolicyModel? policy;

  const RoadsideAssist({
    required this.policyNumber,
    super.key,
    this.policy,
  });

  @override
  Widget build(BuildContext context) {
    final String displayNumber = policy?.policyNumber ?? policyNumber;

    // Usar la fecha de creación como fecha de membresía o un valor predeterminado
    final String memberSince = policy?.createdDate != null
        ? _formatMemberSince(policy?.createdDate ?? '')
        : 'May 2024';

    return Card(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width - 48,
        height: 170,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/home/icons/truckservice.png',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Roadside Assistance',
                        style: TextStyle(
                          fontSize:
                              responsiveFontSizes.policyCardTitle(context),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        child: Text(
                          displayNumber,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Open Sans',
                            fontSize:
                                responsiveFontSizes.policyCardSubtitle(context),
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        'Active',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: responsiveFontSizes.button(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/home/icons/freeautoclub.png',
                    width: 90,
                    height: 20,
                    fit: BoxFit.contain,
                    alignment: Alignment.centerLeft,
                  ),
                  const SizedBox(width: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Member Since $memberSince',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: responsiveFontSizes.bodySmall(context),
                          color: const Color(0xFF414648),
                        ),
                      ),
                      Text(
                        'Single Annual Plan',
                        style: TextStyle(
                          fontFamily: 'Open Sans',
                          fontSize: responsiveFontSizes.bodySmall(context),
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Spacer(flex: 1),
            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 85,
                  height: 38,
                  child: OutlinedButton(
                    onPressed: () {
                      // Acción para ver la tarjeta de ID
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFC74E10),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      minimumSize: const Size(85, 38),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'ID Card',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: responsiveFontSizes.button(context),
                        fontWeight: FontWeight.w700,
                        height: 18 / 14,
                        letterSpacing: 0,
                        color: const Color(0xFFC74E10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 130,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para solicitar servicio
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0047BB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Service Request',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: responsiveFontSizes.button(context),
                        fontWeight: FontWeight.w700,
                        height: 18 / 14,
                        letterSpacing: 0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                SizedBox(
                  width: 90,
                  height: 38,
                  child: ElevatedButton(
                    onPressed: () {
                      // Acción para ver detalles del plan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A8EAA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      'Plan Details',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.visible,
                      maxLines: 1,
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontSize: responsiveFontSizes.button(context),
                        fontWeight: FontWeight.w700,
                        height: 18 / 14,
                        letterSpacing: 0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Método para formatear la fecha de creación como mes y año
  String _formatMemberSince(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final month = _getMonthName(date.month);
      return '$month ${date.year}';
    } catch (e) {
      return 'May 2024'; // Valor predeterminado
    }
  }

  // Método auxiliar para obtener el nombre del mes
  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }
}
