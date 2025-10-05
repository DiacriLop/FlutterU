import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/fake_service.dart';
import '../widgets/product_card.dart'; // Asegúrate de que ProductCard acepte 'subtitle'

class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<FutureScreen> createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {
  late Future<String> _future;

  final List<Map<String, String>> _items = [
    {
      'title': 'Elemento 1',
      'subtitle': 'Descripción del elemento 1',
      'image': 'assets/images/cina.jpg'
    },
    {
      'title': 'Elemento 2',
      'subtitle': 'Descripción del elemento 2',
      'image': 'assets/images/cina.jpg'
    },
    {
      'title': 'Elemento 3',
      'subtitle': 'Descripción del elemento 3',
      'image': 'assets/images/cina.jpg'
    },
    {
      'title': 'Elemento 4',
      'subtitle': 'Descripción del elemento 4',
      'image': 'assets/images/cina.jpg'
    },
  ];

  @override
  void initState() {
    super.initState();
    _startFetch();
  }

  void _startFetch() {
    setState(() {
      _future = fetchData(); // Tu servicio simulado
    });
  }

  void _volverInteligente() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future/Async/Await'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Volver',
          onPressed: _volverInteligente,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<String>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Cargando...', style: TextStyle(fontSize: 20)),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 48),
                    const SizedBox(height: 16),
                    Text('Error: ${snapshot.error}', style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                      onPressed: _startFetch,
                    ),
                  ],
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 48),
                  const SizedBox(height: 16),
                  Text(snapshot.data ?? 'Sin datos', style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 16),

                  // Grid de elementos tipo catálogo
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 0.78,
                      ),
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        final item = _items[index];
                        return ProductCard(
                          title: item['title']!, // ahora es válido
                          imagePath: item['image']!,
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Seleccionaste ${item['title']}')),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Botón para volver a consultar
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Volver a consultar'),
                    onPressed: _startFetch,
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
                        backgroundColor: Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _volverInteligente,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
