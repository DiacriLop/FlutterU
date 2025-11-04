import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../services/universidad_service.dart';
import '../../../models/universidad.dart';
import 'universidad_form_screen.dart';

class UniversidadListScreen extends StatelessWidget {
  const UniversidadListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Universidades'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _navigateToForm(context, null),
          ),
        ],
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: context.watch<UniversidadService>().getUniversidades(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final universidades = snapshot.data ?? [];

          if (universidades.isEmpty) {
            return const Center(
              child: Text('No hay universidades registradas'),
            );
          }

          return ListView.builder(
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final universidad = universidades[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    universidad.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('NIT: ${universidad.nit}'),
                      Text('Tel: ${universidad.telefono}'),
                      InkWell(
                        onTap: () => _launchURL(universidad.paginaWeb),
                        child: Text(
                          'Sitio web',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(context, universidad),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _confirmarEliminacion(context, universidad),
                      ),
                    ],
                  ),
                  onTap: () => _mostrarDetalle(context, universidad),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(context, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateToForm(BuildContext context, Universidad? universidad) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UniversidadFormScreen(universidad: universidad),
      ),
    );
  }

  void _mostrarDetalle(BuildContext context, Universidad universidad) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(universidad.nombre),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildInfoRow('NIT:', universidad.nit),
              const SizedBox(height: 8),
              _buildInfoRow('Dirección:', universidad.direccion),
              const SizedBox(height: 8),
              _buildInfoRow('Teléfono:', universidad.telefono),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _launchURL(universidad.paginaWeb),
                child: _buildInfoRow(
                  'Sitio web:',
                  universidad.paginaWeb,
                  isLink: true,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isLink = false}) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black87, fontSize: 16),
        children: [
          TextSpan(
            text: '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: value,
            style: isLink
                ? const TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  )
                : null,
          ),
        ],
      ),
    );
  }

  Future<void> _confirmarEliminacion(
      BuildContext context, Universidad universidad) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
            '¿Estás seguro de eliminar la universidad ${universidad.nombre}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmado == true) {
      try {
        if (universidad.id != null) {
          await context
              .read<UniversidadService>()
              .eliminarUniversidad(universidad.id!);
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Universidad eliminada correctamente'),
                backgroundColor: Colors.green,
              ),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error al eliminar: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir $url';
    }
  }
}
