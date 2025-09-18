import 'package:flutter/material.dart';
import 'package:taller1/routes/app_router.dart'; // este es el que exporta appRouter
import 'themes/app_theme.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.darkTheme,
      title: 'Tienda de ropa',
      routerConfig: appRouter, // aquí ya se usa
    );
  }
}

