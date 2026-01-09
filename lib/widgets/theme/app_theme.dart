import 'package:acceptance_app/utils/responsive_font_sizes.dart';
import 'package:flutter/material.dart';

// Paleta de colores corporativa de Acceptance

class AppTheme {
  // Colores principales
  static const Color acceptanceBlue =
      Color(0xFF001689); // HEX: #001689, RGB: 0, 22, 137
  static const Color acceptanceGreen =
      Color(0xFF4C9C2E); // HEX: #3C9C2E, RGB: 76, 156, 46

  // Colores secundarios
  static const Color orange =
      Color(0xFFFA6E1C); // HEX: #FA6E1C, RGB: 250, 110, 28
  static const Color blackColor =
      Color(0xFF000000); // HEX: #000000, RGB: 0, 0, 0
  static const Color coolGray =
      Color(0xFF616366); // HEX: #616366, RGB: 97, 99, 102

  // Colores de fondo
  static const Color backgroundGreen = Color(0xFFDBEBD6); // HEX: #DBEBD6
  static const Color backgroundBlue = Color(0xFFB2BADB); // HEX: #B2BADB
  static const Color backgroundOrange = Color(0xFFFFE3D1); // HEX: #FFE3D1
  static const Color backgroundGray = Color(0xFFF2F5F5); // HEX: #F2F5F5

  // Colores adicionales
  static const Color whiteColor = Colors.white;
  static const Color redColor = Color(0xFFE53935);
  static const Color yellowColor = Color(0xFFFFD600);
  // Método para obtener colores según el tema
  static Color getPrimaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF7AA2FF) // Azul Claro de Acceptance para modo oscuro
        : acceptanceBlue; // Azul de Acceptance para modo claro
  }

  static Color getSecondaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? acceptanceGreen.withValues(
            alpha: 5,
          ) // Verde de Acceptance con opacidad para modo oscuro
        : acceptanceGreen; // Verde de Acceptance para modo claro
  }

  static Color getBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF131826) // Color oscuro para modo oscuro
        : backgroundGray; // Gris de fondo para modo claro
  }

  static Color getBackgroundHeaderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF38455D) // Color oscuro para modo oscuro
        : acceptanceBlue; // Azul de Acceptance para modo claro
  }

  static Color getTextGreyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white // Gris más claro para modo oscuro
        : coolGray; // Cool Gray para modo claro
  }

  static Color getDetailsGreyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFABB2BF) // Gris más claro para modo oscuro
        : coolGray; // Cool Gray para modo claro
  }

  static Color getCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF38455D) // Azul oscuro para tarjetas en modo oscuro
        : Colors.white; // Blanco para tarjetas en modo claro
  }

  static Color getIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : acceptanceBlue; // Azul de Acceptance para iconos en modo claro
  }

  static Color getBorderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? acceptanceBlue.withValues(
            alpha: 128,
          ) // Azul de Acceptance con opacidad para modo oscuro
        : coolGray.withValues(
            alpha: 128,
          ); // Cool Gray con opacidad para modo claro
  }

  static Color getBrightnessColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? acceptanceBlue.withAlpha(51)
        : Colors.grey.withAlpha(26);
  }

  static Color getIconToogleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? orange
        : acceptanceBlue;
  }

  static Color getTitleTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : blackColor;
  }

  static Color getIndicatorCurrentIndexCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? acceptanceBlue.withValues(alpha: 204)
        : acceptanceBlue;
  }

  static Color getIndicatorIndexCardColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : blackColor.withAlpha(13);
  }

  static Color getBlueColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? acceptanceBlue.withValues(
            alpha: 5,
          ) // Azul de Acceptance con opacidad para modo oscuro
        : acceptanceBlue; // Azul de Acceptance para modo claro
  }

  static Color getOrangeColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? orange.withValues(alpha: 5)
        : orange;
  }

  static Color getGreenColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? acceptanceGreen
        : acceptanceGreen;
  }

  static Color getRedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.red
        : Colors.redAccent;
  }

  static Color getYellowColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.yellow
        : Colors.yellowAccent;
  }

  static Color getBackgroundGreenColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.green[50]!
        : Colors.green[100]!;
  }

  static Color getBackgroundBlueColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.blue[50]!
        : Colors.blue[100]!;
  }

  static Color getBackgroundOrangeColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.orange[50]!
        : Colors.orange[100]!;
  }

  static Color getBackgroundRedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.red[50]!
        : Colors.red[100]!;
  }

  static Color getBorderRedColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.red.withAlpha(200)
        : Colors.red.withAlpha(50);
  }

  static Color getSubtitleTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey
        : const Color(0xFF414648);
  }

  static Color getBoxShadowColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0x0FFFFFFF)
        : const Color(0x0F000000);
  }

  static Color getBodyTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF414648)
        : const Color(0xFF6B7280);
  }

  static String getFreewayLogoType(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? 'assets/auth/freeway_logo_white.png'
        : 'assets/auth/freeway_logo.png';
  }

  // Colores constantes para compatibilidad con código existente
  static const Color primaryColor = Color(0xFF0047CC);
  static const Color secondaryColor = Color(0xFF0A557A);
  static const Color tertiaryColor = Color(0xFFC84C14);
  static const Color backgroundColor = Color(0xFFf3f3f9);
  static const Color backgroundGreenColor = Color(0xFFF7FFF2);
  static const Color backgroundBlueColor = Color(0xFFEFF6FF);
  static const Color backgroundOrangeColor = Color(0xFFFFF0DF);
  static const Color textGreyColor = Color(0xFF6B7280);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Colors.grey;

  // Text Styles dinámicos
  static TextStyle getTitleStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lato',
      fontWeight: FontWeight.w700, // Bold
      fontSize: 22,
      height: 1.0,
      letterSpacing: 0,
      color: getPrimaryColor(context),
    );
  }

  static TextStyle getButtonTextStyle(BuildContext context) {
    return const TextStyle(
      fontFamily: 'Lato',
      fontSize: 18,
      fontWeight: FontWeight.w600, // SemiBold
      height: 22 / 18,
      letterSpacing: 0,
      color: whiteColor,
    );
  }

  static TextStyle getLinkTextStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lato',
      fontSize: 14,
      fontWeight: FontWeight.w600, // SemiBold
      color: getPrimaryColor(context),
    );
  }

  static TextStyle getGreyTextStyle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Lato',
      color: getTextGreyColor(context),
      fontSize: 14,
      fontWeight: FontWeight.w300, // Light
    );
  }

  // Text Styles constantes para compatibilidad con código existente
  static const TextStyle titleStyle = TextStyle(
    fontFamily: 'Lato',
    fontWeight: FontWeight.w700, // Bold
    fontSize: 22,
    height: 1.0,
    letterSpacing: 0,
    color: primaryColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 18,
    fontWeight: FontWeight.w600, // SemiBold
    height: 22 / 18,
    letterSpacing: 0,
    color: whiteColor,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontFamily: 'Lato',
    fontSize: 14,
    fontWeight: FontWeight.w600, // SemiBold
    color: primaryColor,
  );

  static const TextStyle greyTextStyle = TextStyle(
    fontFamily: 'Lato',
    color: textGreyColor,
    fontSize: 14,
    fontWeight: FontWeight.w300, // Light
  );

  // Input Decoration dinámico
  static InputDecoration getInputDecoration(
    BuildContext context, {
    required String labelText,
  }) {
    return InputDecoration(
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: getBorderColor(context)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: getBorderColor(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: getPrimaryColor(context)),
      ),
      filled: true,
      fillColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF162544) // Color oscuro para el fondo del input
          : whiteColor,
    );
  }

  // Input Decoration constante para compatibilidad con código existente
  static InputDecoration inputDecoration(
    BuildContext context,
    // ignore: require_trailing_commas
    {
    required String labelText,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: getTitleTextColor(context),
        fontSize: responsiveFontSizes.bodyMedium(context),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: getDetailsGreyColor(context)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: getPrimaryColor(context)),
      ),
      filled: true,
      fillColor: AppTheme.getCardColor(context),
      errorMaxLines: 3, // Permitir hasta 3 líneas para mensajes de error
      errorStyle: TextStyle(
        color: Colors.red[700],
        fontSize: responsiveFontSizes.errorText(context),
        height: 1.2, // Espaciado de línea más compacto
      ),
      helperMaxLines: 3, // Permitir hasta 3 líneas para mensajes de ayuda
      helperStyle: TextStyle(
        color: getTextGreyColor(context),
        fontSize: responsiveFontSizes.helperText(context),
        height: 1.2, // Espaciado de línea más compacto
      ),
      suffixIcon: suffixIcon,
    );
  }

  // Button Style dinámico
  static ButtonStyle getPrimaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: getPrimaryColor(context),
      foregroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      minimumSize: const Size(double.infinity, 50),
    );
  }

  // Button Style constante para compatibilidad con código existente
  static ButtonStyle primaryButtonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      backgroundColor: AppTheme.getPrimaryColor(context),
      foregroundColor: whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
      minimumSize: const Size(double.infinity, 50),
    );
  }
}
