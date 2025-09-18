import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primaryContainer, 
            ),
            child: const Text(
              'Menú',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255), // Texto blanco para contrastar con el color primario
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              //context.go('/'); // Navega a la ruta principal
              //Reemplaza la ruta actual en la pila de navegación.
              //No permite volver atrás automáticamente, ya que no agrega la nueva ruta a la pila.
              //Útil para navegación sin historial, como en barra de navegación o cambiar de pestañas.
              context.go('/'); // Navega a la ruta principal
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.checkroom),
            title: const Text('Catalogo'),
            onTap: () {
    // Navega usando el nombre de la ruta
    // Es más seguro porque si cambias el path, el name se mantiene
            context.goNamed('catalogo'); 
            Navigator.pop(context); // Cierra el Drawer
            },
        ),

          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
            onTap: () {
              //context.replace(String route)
              //Similar a go(), pero en este caso reemplaza la ruta actual sin eliminar el historial anterior.
              //Útil si quieres evitar que el usuario regrese a la pantalla anterior
              //pero manteniendo la posibilidad de navegar hacia otras rutas en la pila
              context.replace('/perfil'); // Navega a la pantalla de perfil
              Navigator.pop(context); // Cierra el drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              context.go('/ciclo_vida');
            },
          ),
        ],
      ),
    );
  }
}
