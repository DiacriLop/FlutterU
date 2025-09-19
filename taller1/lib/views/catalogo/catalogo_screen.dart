import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taller1/widgets/custom_drawer.dart';
import 'package:taller1/widgets/product_card.dart';

class CatalogoScreen extends StatelessWidget {
  const CatalogoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Recibir parámetro opcional desde Home (ej. ?promo=... )
    final promo = GoRouterState.of(context).uri.queryParameters['promo'] ?? "Sin promo";

    /// Método para volver de manera "inteligente"
    void volverInteligente() {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop(); // vuelve si hay historial
      } else {
        context.go('/'); // si no, lleva al Home
      }
    }

    return DefaultTabController(
      length: 3, // ✅ 3 secciones
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catálogo'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: 'Volver',
            onPressed: volverInteligente,
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "Ropa", icon: Icon(Icons.checkroom)),
              Tab(text: "Electrónica", icon: Icon(Icons.devices)),
              Tab(text: "Hogar", icon: Icon(Icons.chair)),
            ],
          ),
        ),
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Mensaje con parámetro recibido
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blueAccent),
                ),
                child: Text(
                  "🛍️ Bienvenido al catálogo\nPromo activa: $promo",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              // Barra de búsqueda
              TextField(
                decoration: InputDecoration(
                  hintText: "Buscar producto...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                ),
              ),
              const SizedBox(height: 16),

              // ✅ Widget adicional: Card de oferta
              Card(
                color: Colors.orange.shade100,
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.local_offer, color: Colors.orange),
                      SizedBox(width: 8),
                      Text(
                        "¡Oferta especial del día!",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ✅ TabBarView con GridView en cada tab
              Expanded(
                child: TabBarView(
                  children: [
                    // 🧥 Tab de Ropa
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          title: "Ropa ${index + 1}",
                          imagePath: "assets/images/cina.jpg",
                          onTap: () {
                            context.push('/ciclo-vida');
                          },
                        );
                      },
                    ),

                    // 📱 Tab de Electrónica
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          title: "Electrónico ${index + 1}",
                          imagePath: "assets/images/cina.jpg",
                          onTap: () {
                            context.push('/ciclo-vida');
                          },
                        );
                      },
                    ),

                    // 🏠 Tab de Hogar
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          title: "Hogar ${index + 1}",
                          imagePath: "assets/images/cina.jpg",
                          onTap: () {
                            context.push('/ciclo-vida');
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Botón que vuelve al menú principal
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Volver al Home"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: volverInteligente,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



