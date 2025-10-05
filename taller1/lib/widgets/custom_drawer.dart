import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primaryContainer,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: const Center(
              child: Text(
                'Menú Principal',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _drawerItem(
                  context,
                  icon: Icons.home,
                  text: 'Inicio',
                  onTap: () {
                    context.go('/');
                    Navigator.pop(context);
                  },
                ),
                _drawerItem(
                  context,
                  icon: Icons.checkroom,
                  text: 'Catálogo',
                  onTap: () {
                    context.go('/catalogo');
                    Navigator.pop(context);
                  },
                ),
                _drawerItem(
                  context,
                  icon: Icons.person,
                  text: 'Perfil',
                  onTap: () {
                    context.go('/perfil');
                    Navigator.pop(context);
                  },
                ),
                _drawerItem(
                  context,
                  icon: Icons.loop,
                  text: 'Ciclo de Vida',
                  onTap: () {
                    context.go('/ciclo_vida');
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                _drawerItem(
                  context,
                  icon: Icons.input,
                  text: 'Future',
                  onTap: () {
                    context.go('/future');
                    Navigator.pop(context);
                  },
                ),
                _drawerItem(
                  context,
                  icon: Icons.timer,
                  text: 'Timer',
                  onTap: () {
                    context.go('/timer');
                    Navigator.pop(context);
                  },
                ),
                _drawerItem(
                  context,
                  icon: Icons.memory,
                  text: 'Isolate',
                  onTap: () {
                    context.go('/isolate');
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              '© 2025 Taller Electiva',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context,
      {required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(
        text,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
      hoverColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.1),
    );
  }
}
