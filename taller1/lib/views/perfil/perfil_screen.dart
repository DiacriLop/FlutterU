import 'package:flutter/material.dart';
import 'package:taller1/services/auth_service.dart';
import 'package:taller1/widgets/custom_drawer.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final AuthService _authService = AuthService();
  bool _isLoading = true;
  String? _name;
  String? _email;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final user = await _authService.getUser();
    final token = await _authService.getToken();

    setState(() {
      _name = user?.name;
      _email = user?.email;
      _token = token;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil - Sistema de Parqueo')),
      drawer: const CustomDrawer(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      child: Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      _name ?? 'Sin nombre',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _email ?? 'Sin correo',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 24),

                    _DataCard(
                      title: 'Datos Almacenados en SharedPreferences',
                      subtitle: 'Información NO sensible',
                      color: Colors.orange.shade700,
                      children: [
                        _InfoRow(label: 'ID de Usuario', value: _name != null ? '—' : 'No disponible'),
                        _InfoRow(label: 'Nombre', value: _name ?? 'No disponible'),
                        _InfoRow(label: 'Email', value: _email ?? 'No disponible'),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _DataCard(
                      title: 'Datos Almacenados en FlutterSecureStorage',
                      subtitle: 'Información sensible (encriptada)',
                      color: Colors.green.shade700,
                      children: [
                        _InfoRow(label: 'Token JWT', value: _token != null ? '●●●●●●●●' : 'No disponible'),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(Icons.check_circle, color: Colors.lightGreenAccent, size: 20),
                            SizedBox(width: 8),
                            Text('Estado de Sesión', style: TextStyle(fontWeight: FontWeight.bold)),
                            Spacer(),
                            Text('Activa'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class _DataCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final List<Widget> children;

  const _DataCard({
    required this.title,
    required this.subtitle,
    required this.color,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(color: color.withOpacity(0.7)),
          ),
          const Divider(height: 24),
          ...children,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          Text(
            value,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

