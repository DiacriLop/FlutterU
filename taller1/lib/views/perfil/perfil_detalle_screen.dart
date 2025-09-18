import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// !PerfilDetalleScreen
/// Muestra la información recibida desde PerfilScreen
/// y demuestra el comportamiento según el método usado (go, push, replace).
class PerfilDetalleScreen extends StatelessWidget {
  final String nombre;
  final String correo;
  final String metodo;

  const PerfilDetalleScreen({
    super.key,
    required this.nombre,
    required this.correo,
    required this.metodo,
  });

  /// Método para manejar el regreso de forma inteligente
  void volverInteligente(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      // ✅ Hay historial, se puede hacer pop()
      context.pop();
    } else {
      // ❌ No hay historial, navegamos manualmente
      context.go('/perfil'); // también podrías poner '/' si quieres ir al Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalle del Perfil"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => volverInteligente(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Datos recibidos:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Datos recibidos
            Text("👤 Nombre: $nombre", style: const TextStyle(fontSize: 18)),
            Text("📧 Correo: $correo", style: const TextStyle(fontSize: 18)),

            const SizedBox(height: 20),
            Text("Método usado: $metodo",
                style: const TextStyle(fontSize: 16, color: Colors.grey)),

            const SizedBox(height: 40),

            // 🔙 Volver a la pantalla anterior (inteligente)
            ElevatedButton.icon(
              onPressed: () => volverInteligente(context),
              icon: const Icon(Icons.arrow_back),
              label: const Text("Volver atrás"),
            ),

            const SizedBox(height: 15),

            // 🏠 Ir al menú principal
            ElevatedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text("Ir al Home"),
            ),
          ],
        ),
      ),
    );
  }
}
