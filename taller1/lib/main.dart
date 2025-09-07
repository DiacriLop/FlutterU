import 'package:flutter/material.dart';

// Función principal que inicia la aplicación Flutter.
void main() {
  runApp(const MyApp());
}

// Widget raíz de la aplicación.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Construye el MaterialApp, que define el tema y la pantalla principal.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // Título de la app.
      theme: ThemeData(
        // Define el esquema de colores de la app.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hola, Flutter'), // Pantalla principal.
    );
  }
}

// Widget de la pantalla principal, con estado.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title; // Título que se muestra en el AppBar.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// Estado de la pantalla principal.
class _MyHomePageState extends State<MyHomePage> {
  String _appBarTitle = 'Hola, Flutter'; // Variable de estado para el título del AppBar.

  // Alterna el título del AppBar y muestra un SnackBar.
  void _toggleTitle() {
    setState(() {
      _appBarTitle = _appBarTitle == 'Hola, Flutter' ? '¡Título cambiado!' : 'Hola, Flutter';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Título actualizado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, // Color del AppBar.
        title: Text(_appBarTitle), // Título dinámico del AppBar.
      ),
      body: SingleChildScrollView( // Permite desplazamiento si el contenido es grande.
        padding: const EdgeInsets.all(16.0), // Espaciado general.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estira los hijos horizontalmente.
          children: [
            // Container con márgenes, color y borde alrededor del nombre.
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                border: Border.all(color: Colors.deepPurple, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Diana Cristina Lopez Reyes', // Nombre del estudiante.
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16), // Espaciado vertical.

            // Row con dos imágenes: una de red y una de assets.
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  'https://i.blogs.es/8256d5/gpu-openai-chatgpt/500_333.jpeg',
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 80),
                ),
                const SizedBox(width: 16),
                Image.asset(
                  'assets/images/si.jpeg', // se agrega esta imagen en assets y declararla en pubspec.yaml.
                  width: 80,
                  height: 80,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 80),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ListView horizontal con 3 elementos, cada uno con icono y texto.
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SizedBox(
                    width: 120,
                    child: ListTile(
                      leading: Icon(Icons.star, color: Colors.deepPurple),
                      title: Text('Elemento 1'),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ListTile(
                      leading: Icon(Icons.favorite, color: Colors.pink),
                      title: Text('Elemento 2'),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ListTile(
                      leading: Icon(Icons.cake, color: Colors.orange),
                      title: Text('Elemento 3'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Stack: superpone texto sobre una imagen.
            Stack(
              alignment: Alignment.center,
              children: [
                Image.network(
                  'https://revistaclevel.com/sites/default/files/styles/wide/public/ChatGPT%20Image%2029%20mar%202025%2C%2005_37_43%20p.m..jpg',
                  width: 200,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 200,
                    height: 120,
                    color: Colors.grey,
                    child: const Icon(Icons.error, size: 40),
                  ),
                ),
                Container(
                  color: Colors.black54,
                  width: 200,
                  height: 120,
                  child: const Center(
                    child: Text(
                      'Codigo 230222003',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // GridView con 4 celdas de texto.
            SizedBox(
              height: 120,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 2,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Card(child: Center(child: Text('Celda 1'))),
                  Card(child: Center(child: Text('Celda 2'))),
                  Card(child: Center(child: Text('Celda 3'))),
                  Card(child: Center(child: Text('Celda 4'))),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Botón que alterna el título del AppBar y muestra SnackBar.
            ElevatedButton(
              onPressed: _toggleTitle,
              child: const Text('Cambiar título'),
            ),
            const SizedBox(height: 8),

            // Botón adicional con icono y acción.
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('¡Acción extra!')),
                );
              },
              icon: const Icon(Icons.info),
              label: const Text('Botón con icono'),
            ),
          ],
        ),
      ),
    );
  }
}
