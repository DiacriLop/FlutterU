import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:taller1/routes/app_router.dart';
import 'package:taller1/themes/app_theme.dart';
import 'package:taller1/services/universidad_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => UniversidadService()),
      ],
      child: MaterialApp.router(
        theme: AppTheme.darkTheme,
        title: 'Gestión de Universidades',
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

