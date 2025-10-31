import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _secureStorage = const FlutterSecureStorage();
  // AuthService instance not required here because we read directly from
  // SharedPreferences and FlutterSecureStorage in this screen.

  String? userName;
  String? userEmail;
  int? userId;

  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    // Cargar datos de SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      userEmail = prefs.getString('user_email');
      userId = prefs.getInt('user_id');
    });

    // Cargar datos de FlutterSecureStorage
    final tokenValue = await _secureStorage.read(key: 'token');
    setState(() {
      token = tokenValue;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Mi Perfil - Sistema de Parqueo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
            tooltip: 'Recargar datos',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Avatar y nombre
                  Center(
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.person, size: 60, color: Colors.white),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          userName ?? 'Usuario',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          userEmail ?? 'No disponible',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // SharedPreferences
                  _buildSection(
                    'Datos Almacenados en SharedPreferences',
                    'Información NO sensible',
                    [
                      _buildDataItem('ID de Usuario', userId?.toString() ?? 'N/A'),
                      _buildDataItem('Nombre', userName ?? 'N/A'),
                      _buildDataItem('Email', userEmail ?? 'N/A'),
                    ],
                    Colors.orange,
                  ),
                  const SizedBox(height: 24),

                  // FlutterSecureStorage
                  _buildSection(
                    'Datos Almacenados en FlutterSecureStorage',
                    'Información sensible (encriptada)',
                    [
                      _buildDataItem(
                        'Token JWT',
                        token != null
                            ? '${token!.substring(0, 20)}...'
                            : 'No disponible',
                        isSecret: true,
                      ),
                      _buildDataItem(
                        'Estado de Sesión',
                        token != null ? 'Activa' : 'Inactiva',
                        customIcon: token != null
                            ? const Icon(Icons.check_circle, color: Colors.green, size: 20)
                            : const Icon(Icons.error, color: Colors.red, size: 20),
                      ),
                    ],
                    Colors.green,
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSection(
    String title,
    String subtitle,
    List<Widget> items,
    MaterialColor color,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color.shade700,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
            const Divider(height: 24),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildDataItem(String label, String value,
      {bool isSecret = false, Widget? customIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (customIcon != null) ...[
            customIcon,
            const SizedBox(width: 8),
          ],
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
                fontFamily: isSecret ? 'monospace' : null,
                fontSize: isSecret ? 12 : 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
