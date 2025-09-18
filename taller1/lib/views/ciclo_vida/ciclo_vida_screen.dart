import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// CicloVidaScreen
/// Demuestra el ciclo de vida de un StatefulWidget
/// simulando un producto en un carrito de compras.

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => CicloVidaScreenState();
}

class CicloVidaScreenState extends State<CicloVidaScreen> {
  int cantidad = 1; // estado inicial del producto

  /// Se ejecuta una vez cuando la pantalla es creada.
  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("🟢 initState() -> La pantalla del carrito se ha inicializado");
    }
  }

  /// Se ejecuta cuando cambian las dependencias del widget
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print("🟡 didChangeDependencies() -> Dependencias cambiaron (ej: tema)");
    }
  }

  /// Se ejecuta cada vez que el widget es reconstruido.
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("🔵 build() -> Construyendo la pantalla del carrito");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("🛒 Carrito de Compras"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen del producto
            Image.asset(
              "assets/images/cina.jpg",
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Nombre del producto
            const Text(
              "Cinnamoroll Plush",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Cantidad seleccionada
            Text(
              "Cantidad: $cantidad",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),

            // Botón para actualizar cantidad
            ElevatedButton(
              onPressed: () {
                setState(() {
                  cantidad++;
                  if (kDebugMode) {
                    print("🟠 setState() -> Cantidad aumentada a $cantidad");
                  }
                });
              },
              child: const Text("Agregar otro"),
            ),
            const SizedBox(height: 20),

            // Botón para volver al menú principal
            ElevatedButton.icon(
              onPressed: () {
                if (kDebugMode) {
                  print("⬅️ Volviendo al home");
                }
                context.go('/'); // vuelve al HomeScreen
              },
              icon: const Icon(Icons.arrow_back),
              label: const Text("Volver al Home"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Se ejecuta cuando el widget es eliminado de la memoria.
  @override
  void dispose() {
    if (kDebugMode) {
      print("🔴 dispose() -> La pantalla del carrito se ha destruido");
    }
    super.dispose();
  }
}