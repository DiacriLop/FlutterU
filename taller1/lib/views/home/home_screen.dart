import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tienda Cinnamoroll'),
        centerTitle: true,
      ),
      drawer: const CustomDrawer(),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '✨ Bienvenido a la Tienda de artículos de Cinnamoroll ✨',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // Imagen decorativa
            Image.asset(
              "assets/images/cina.jpg",
              height: 150,
            ),

            const SizedBox(height: 30),

            // Botón que navega al catálogo con parámetro
            ElevatedButton.icon(
              icon: const Icon(Icons.shopping_bag),
              label: const Text("Ir al Catálogo"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Aquí pasamos un parámetro al catálogo
                context.go('/catalogo?promo=Bienvenido');
              },
            ),

            const SizedBox(height: 20),

            // Extra: Ejemplo con push
            ElevatedButton(
              child: const Text("Ir al Catálogo con push()"),
              onPressed: () {
                context.push('/catalogo?promo=ConPush');
              },
            ),

            const SizedBox(height: 10),

            // Extra: Ejemplo con replace
            ElevatedButton(
              child: const Text("Ir al Catálogo con replace()"),
              onPressed: () {
                context.replace('/catalogo?promo=ConReplace');
              },
            ),
          ],
        ),
      ),
    );
  }
}
