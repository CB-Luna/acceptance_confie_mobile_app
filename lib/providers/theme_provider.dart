import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  ThemeData get currentTheme => _isDarkMode
      ? ThemeData.dark().copyWith(
          primaryColor: Colors.blue,
          primaryColorDark: Colors.blue[900],
          primaryColorLight: Colors.blue[700],
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.blue[900],
          ),
          scaffoldBackgroundColor: const Color(0xFF0D1B3E), // Azul muy oscuro
          cardColor: const Color(0xFF162544),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.blue[900],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.blue[200],
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white70),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          colorScheme: ColorScheme.dark(
            primary: Colors.blue[400]!,
            secondary: Colors.blue[300]!,
            surface: const Color(0xFF162544),
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onSurface: Colors.white,
          ),
          dialogTheme:
              const DialogThemeData(backgroundColor: Color(0xFF162544)),
        )
      : ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          colorScheme: ColorScheme.light(
            primary: Colors.blue,
            secondary: Colors.blue[300]!,
          ),
        );
}
