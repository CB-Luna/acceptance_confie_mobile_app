import 'package:flutter/material.dart';
import 'package:freeway_app/models/user_model.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';
import 'package:intl/intl.dart';

class IdCardWidget extends StatelessWidget {
  final User user;
  final String? policyNumber;
  final String? carrier;
  final String? state;
  final DateTime? effectiveDate;
  final DateTime? expirationDate;
  final double width;
  final double height;

  const IdCardWidget({
    required this.user,
    required this.width,
    required this.height,
    super.key,
    this.policyNumber,
    this.carrier,
    this.state,
    this.effectiveDate,
    this.expirationDate,
  });

  @override
  Widget build(BuildContext context) {
    // Usar el número de póliza proporcionado o el del usuario
    final displayPolicyNumber = policyNumber ?? user.policyNumber;

    // Formatear fechas
    final dateFormat = DateFormat('MM/dd/yyyy');
    final effectiveDateStr = effectiveDate != null
        ? dateFormat.format(effectiveDate!)
        : '--/--/----';
    final expirationDateStr = expirationDate != null
        ? dateFormat.format(expirationDate!)
        : '--/--/----';

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppTheme.getCardColor(context),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppTheme.getBoxShadowColor(context),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header azul con logo
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppTheme.getPrimaryColor(context), // Color azul de Freeway
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/home/idcardicons/freeway_logo_white.png',
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Freeway Insurance',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Contenido de la tarjeta
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección de información del asegurado
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Named Insured
                        Text(
                          context.translate('idCard.namedInsured'),
                          style: TextStyle(
                            fontSize: 14,
                            color: AppTheme.getTextGreyColor(context),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Nombre del asegurado
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            user.fullName,
                            style: TextStyle(
                              fontSize: 22,
                              color: AppTheme.getPrimaryColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Fila con la información de la aseguradora y número de póliza
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Carrier
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.translate('idCard.carrier'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.getTextGreyColor(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Usar FittedBox para adaptar el texto al espacio disponible
                              Text(
                                carrier ?? 'Infinity',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.getPrimaryColor(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Policy Number
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.translate('idCard.policyNumberLabel'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.getTextGreyColor(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              // Usar FittedBox para adaptar el número de póliza al espacio disponible
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  displayPolicyNumber,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppTheme.getPrimaryColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // State, Effective Date, Expiration Date
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        // State
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.translate('idCard.state'),
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppTheme.getTextGreyColor(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state ?? 'FL',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: AppTheme.getPrimaryColor(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Effective Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.translate('idCard.effectiveDate'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.getTextGreyColor(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                effectiveDateStr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.getPrimaryColor(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Expiration Date
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.translate('idCard.expirationDate'),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.getTextGreyColor(context),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                expirationDateStr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppTheme.getPrimaryColor(context),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer con código de barras
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Image.asset(
                'assets/home/idcardicons/barcode.png',
                width: 280,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
