import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  // Colores para el tema oscuro
  static const Color _darkPrimaryColor = Color(0xFF3B82F6); // Azul más claro
  static const Color _darkSecondaryColor = Color(0xFF1E5D9B); // Azul más oscuro
  static const Color _darkBackgroundColor =
      Color(0xFF0D1B3E); // Azul muy oscuro
  static const Color _darkCardColor =
      Color(0xFF162544); // Azul oscuro para tarjetas
  static const Color _darkTextColor = Colors.white;
  static const Color _darkTextGreyColor = Color(0xFFABB2BF); // Gris más claro
  static const Color _darkIconColor = Colors.white;
  static const Color _darkBorderColor = Color(0xFF3B82F6); // Azul con opacidad

  // Colores para el tema claro
  static const Color _lightPrimaryColor = Color(0xFF0047CC); // Azul original
  static const Color _lightSecondaryColor = Color(0xFF0A557A); // Color original
  static const Color _lightBackgroundColor =
      Color(0xFFF5FCFF); // Color original
  static const Color _lightCardColor = Colors.white;
  static const Color _lightTextColor = Colors.black;
  static const Color _lightTextGreyColor = Color(0xFF6B7280); // Color original
  static const Color _lightIconColor =
      Color(0xFF0A4DA2); // Color azul para iconos
  static const Color _lightBorderColor = Colors.grey;

  ThemeData get currentTheme => _isDarkMode
      ? ThemeData.dark().copyWith(
          primaryColor: _darkPrimaryColor,
          primaryColorDark: _darkPrimaryColor.withValues(alpha: 0.8),
          primaryColorLight: _darkPrimaryColor.withValues(alpha: 0.6),
          appBarTheme: const AppBarTheme(
            backgroundColor: _darkPrimaryColor,
            foregroundColor: _darkTextColor,
            elevation: 0,
          ),
          scaffoldBackgroundColor: _darkBackgroundColor,
          cardColor: _darkCardColor,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: _darkCardColor,
            selectedItemColor: _darkPrimaryColor,
            unselectedItemColor: _darkTextGreyColor,
          ),
          textTheme: const TextTheme(
            // Títulos principales - Bold
            displayLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, color: _darkTextColor),
            displayMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, color: _darkTextColor),
            displaySmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, color: _darkTextColor),
            
            // Subtítulos - Semibold
            headlineLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _darkTextColor),
            headlineMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _darkTextColor),
            headlineSmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _darkTextColor),
            
            // Títulos de sección - Semibold
            titleLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _darkTextColor),
            titleMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _darkTextColor),
            titleSmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _darkTextGreyColor),
            
            // Cuerpo de texto - Regular
            bodyLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, color: _darkTextColor),
            bodyMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, color: _darkTextGreyColor),
            bodySmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, color: _darkTextGreyColor),
            
            // Elementos secundarios - Light
            labelLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, color: _darkTextColor),
            labelMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, color: _darkTextGreyColor),
            labelSmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, color: _darkTextGreyColor),
          ),
          iconTheme: const IconThemeData(
            color: _darkIconColor,
          ),
          colorScheme: const ColorScheme.dark(
            primary: _darkPrimaryColor,
            secondary: _darkSecondaryColor,
            surface: _darkCardColor,
            onPrimary: _darkTextColor,
            onSecondary: _darkTextColor,
            onSurface: _darkTextColor,
          ),
          dialogTheme: const DialogThemeData(
            backgroundColor: _darkCardColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: _darkCardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: _darkBorderColor.withValues(alpha: 0.5)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  BorderSide(color: _darkBorderColor.withValues(alpha: 0.5)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _darkPrimaryColor),
            ),
            labelStyle: const TextStyle(color: _darkTextGreyColor),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: _darkPrimaryColor,
              foregroundColor: _darkTextColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: _darkPrimaryColor,
              side: const BorderSide(color: _darkPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: _darkPrimaryColor,
            ),
          ),
        )
      : ThemeData.light().copyWith(
          primaryColor: _lightPrimaryColor,
          primaryColorDark: _lightPrimaryColor.withValues(alpha: 0.8),
          primaryColorLight: _lightPrimaryColor.withValues(alpha: 0.6),
          appBarTheme: const AppBarTheme(
            backgroundColor: _lightPrimaryColor,
            foregroundColor: _lightTextColor,
            elevation: 0,
          ),
          scaffoldBackgroundColor: _lightBackgroundColor,
          cardColor: _lightCardColor,
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: _lightCardColor,
            selectedItemColor: _lightPrimaryColor,
            unselectedItemColor: _lightTextGreyColor,
          ),
          textTheme: const TextTheme(
            // Títulos principales - Bold
            displayLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, color: _lightTextColor),
            displayMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, color: _lightTextColor),
            displaySmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w700, color: _lightTextColor),
            
            // Subtítulos - Semibold
            headlineLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _lightTextColor),
            headlineMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _lightTextColor),
            headlineSmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _lightTextColor),
            
            // Títulos de sección - Semibold
            titleLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _lightTextColor),
            titleMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _lightTextColor),
            titleSmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w600, color: _lightTextGreyColor),
            
            // Cuerpo de texto - Regular
            bodyLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, color: _lightTextColor),
            bodyMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, color: _lightTextGreyColor),
            bodySmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w400, color: _lightTextGreyColor),
            
            // Elementos secundarios - Light
            labelLarge: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, color: _lightTextColor),
            labelMedium: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, color: _lightTextGreyColor),
            labelSmall: TextStyle(fontFamily: 'Lato', fontWeight: FontWeight.w300, color: _lightTextGreyColor),
          ),
          iconTheme: const IconThemeData(
            color: _lightIconColor,
          ),
          colorScheme: const ColorScheme.light(
            primary: _lightPrimaryColor,
            secondary: _lightSecondaryColor,
            surface: _lightCardColor,
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: _lightTextColor,
          ),
          dialogTheme: const DialogThemeData(
            backgroundColor: _lightCardColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: _lightCardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _lightBorderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _lightBorderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: _lightPrimaryColor),
            ),
            labelStyle: const TextStyle(color: _lightTextGreyColor),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: _lightPrimaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: _lightPrimaryColor,
              side: const BorderSide(color: _lightPrimaryColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: _lightPrimaryColor,
            ),
          ),
        );
}
