import 'package:flutter/material.dart';
import 'package:freeway_app/utils/app_localizations_extension.dart';
import 'package:freeway_app/widgets/theme/app_theme.dart';

import '../contactcenter/request_call.dart';

class ContactAgent extends StatelessWidget {
  const ContactAgent({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la pantalla para cálculos responsive
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Card(
      margin: EdgeInsets.zero,
      color: AppTheme.getCardColor(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        width: screenWidth - 48, // Ancho adaptable
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: 16,
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final availableWidth = constraints.maxWidth;

            // Determinar si debemos usar layout vertical
            final useVerticalLayout = availableWidth < 360;

            if (useVerticalLayout) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Sección de información
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/home/icons/contactagent.png',
                        width: 40,
                        height: 32,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              context
                                  .translate('home.contactAgent.needChanges'),
                              style: TextStyle(
                                color: AppTheme.getOrangeColor(context),
                                fontFamily: 'Open Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              context.translate(
                                'home.contactAgent.contactMyAgent',
                              ),
                              style: TextStyle(
                                color: AppTheme.getPrimaryColor(context),
                                fontFamily: 'Open Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Botón de llamada
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: _buildCallButton(context, isSmallScreen),
                    ),
                  ),
                ],
              );
            }

            // Layout horizontal para pantallas más grandes
            // Calcular el espacio disponible para el texto
            final buttonWidth = isSmallScreen ? 100.0 : 120.0;
            final imageWidth = isSmallScreen ? 40.0 : 47.0;
            final spacingWidth =
                isSmallScreen ? 20.0 : 28.0; // Suma de espacios
            final textWidth =
                availableWidth - buttonWidth - imageWidth - spacingWidth;

            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Sección de información
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/home/icons/contactagent.png',
                      width: imageWidth,
                      height: isSmallScreen ? 32 : 36,
                    ),
                    SizedBox(width: isSmallScreen ? 8 : 12),
                    // Limitar el ancho del texto para evitar desbordamiento
                    SizedBox(
                      width: textWidth,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.translate('home.contactAgent.needChanges'),
                            style: TextStyle(
                              color: AppTheme.getOrangeColor(context),
                              fontFamily: 'Open Sans',
                              fontSize: isSmallScreen ? 13 : 14,
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            context
                                .translate('home.contactAgent.contactMyAgent'),
                            style: TextStyle(
                              color: AppTheme.getPrimaryColor(context),
                              fontFamily: 'Open Sans',
                              fontSize: isSmallScreen ? 13 : 14,
                              fontWeight: FontWeight.bold,
                              height: 1.3,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Botón de llamada
                SizedBox(
                  width: buttonWidth,
                  child: _buildCallButton(context, isSmallScreen),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Método para construir el botón de llamada
  Widget _buildCallButton(BuildContext context, bool isSmallScreen) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RequestCallPage(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.getPrimaryColor(context),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 12 : 16,
          vertical: isSmallScreen ? 8 : 10,
        ),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          context.translate('home.contactAgent.callNow'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.white,
            fontFamily: 'Open Sans',
            fontSize: isSmallScreen ? 13 : 14,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
        ),
      ),
    );
  }
}
