import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../models/dog_model.dart';
import '../../services/dog_service.dart';

class DogListScreen extends StatefulWidget {
  const DogListScreen({super.key});

  @override
  State<DogListScreen> createState() => _DogListScreenState();
}

class _DogListScreenState extends State<DogListScreen> {
  final DogService _dogService = DogService();
  late Future<List<DogBreed>> _dogsFuture;

  @override
  void initState() {
    super.initState();
    _dogsFuture = _dogService.getAllBreeds();
  }

  // ✅ Método inteligente para volver
  void volverInteligente() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop(); // vuelve si hay historial
    } else {
      context.go('/'); // si no, lleva al Home
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Razas de Perros'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => volverInteligente(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<DogBreed>>(
              future: _dogsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 16),
                        Text('Cargando razas...'),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.error_outline, size: 48, color: Colors.red),
                        const SizedBox(height: 16),
                        Text(
                          'Error: ${snapshot.error}'.replaceAll('Exception:', ''),
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.refresh),
                          label: const Text('Reintentar'),
                          onPressed: () {
                            setState(() {
                              _dogsFuture = _dogService.getAllBreeds();
                            });
                          },
                        ),
                      ],
                    ),
                  );
                }

                final dogs = snapshot.data!;
                
                if (dogs.isEmpty) {
                  return const Center(
                    child: Text('No se encontraron razas'),
                  );
                }

                return ListView.builder(
                  itemCount: dogs.length,
                  itemBuilder: (context, index) {
                    final dog = dogs[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        leading: dog.imageUrl != null
                            ? Hero(
                                tag: 'dog_${dog.name}',
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(dog.imageUrl!),
                                ),
                              )
                            : const CircleAvatar(child: Icon(Icons.pets)),
                        title: Text(
                          dog.name.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          dog.subBreeds.isEmpty
                              ? 'Sin subrazas'
                              : 'Subrazas: ${dog.subBreeds.join(", ")}',
                        ),
                        onTap: () {
                          context.pushNamed(
                            'dogDetail',
                            pathParameters: {'breed': dog.name},
                            queryParameters: {'imageUrl': dog.imageUrl ?? ''},
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // ✅ Botón para volver al Home
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text("Volver al menú principal"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: volverInteligente,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
