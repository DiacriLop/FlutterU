import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  static final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          FutureBuilder<User?>(
            future: _authService.getUser(),
            builder: (context, snapshot) {
              final user = snapshot.data;
              return DrawerHeader(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      child: Icon(Icons.person, size: 36),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      user?.name ?? 'Menú Principal',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    if (user?.email != null)
                      Text(
                        user!.email,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              );
            },
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
                _drawerItem(
                  context,
                  icon: Icons.pets,
                  text: 'Razas de Perros',
                  onTap: () {
                    context.go('/dogs');
                    Navigator.pop(context);
                  },
                ),
                const Divider(),
                _drawerItem(
                  context,
                  icon: Icons.verified_user,
                  text: 'Ver Perfil',
                  onTap: () {
                    context.go('/perfil');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.redAccent),
                  title: const Text(
                    'Cerrar sesión',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  onTap: () async {
                    final router = GoRouter.of(context);
                    Navigator.pop(context);
                    await _authService.logout();
                    router.go('/login');
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
