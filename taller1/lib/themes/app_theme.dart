import 'package:flutter/material.dart';


class AppTheme {
  //! tema oscuro
  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color.fromARGB(255, 20, 83, 165), // Color semilla
        brightness: Brightness.dark, // Tema claro
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 35, 121, 201), // Color del AppBar
        titleTextStyle: TextStyle(
          color: Colors.white, // Texto blanco para el AppBar
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 55, 53, 53), // Fondo del Drawer
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Color.fromARGB(221, 255, 255, 255)), // Estilo de texto
        bodyMedium: TextStyle(color: Color.fromARGB(221, 255, 255, 255)),
      ),
    );
  }
}
