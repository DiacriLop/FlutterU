import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/universidad.dart';
import '../../../services/universidad_service.dart';

class UniversidadFormScreen extends StatefulWidget {
  final Universidad? universidad;

  const UniversidadFormScreen({
    Key? key,
    this.universidad,
  }) : super(key: key);

  @override
  _UniversidadFormScreenState createState() => _UniversidadFormScreenState();
}

class _UniversidadFormScreenState extends State<UniversidadFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nitController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _paginaWebController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.universidad != null) {
      _cargarDatos(widget.universidad!);
    }
  }

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _paginaWebController.dispose();
    super.dispose();
  }

  void _cargarDatos(Universidad universidad) {
    _nitController.text = universidad.nit;
    _nombreController.text = universidad.nombre;
    _direccionController.text = universidad.direccion;
    _telefonoController.text = universidad.telefono;
    _paginaWebController.text = universidad.paginaWeb;
  }

  Future<void> _guardarUniversidad() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final universidad = Universidad(
        id: widget.universidad?.id,
        nit: _nitController.text.trim(),
        nombre: _nombreController.text.trim(),
        direccion: _direccionController.text.trim(),
        telefono: _telefonoController.text.trim(),
        paginaWeb: _paginaWebController.text.trim(),
      );

      final universidadService = context.read<UniversidadService>();

      if (widget.universidad == null) {
        await universidadService.crearUniversidad(universidad);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Universidad creada correctamente'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        await universidadService.actualizarUniversidad(universidad);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Universidad actualizada correctamente'),
              backgroundColor: Colors.green,
            ),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al guardar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  bool _validarUrl(String? url) {
    if (url == null || url.isEmpty) return false;
    final uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute && (uri.scheme == 'http' || uri.scheme == 'https');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.universidad == null
              ? 'Nueva Universidad'
              : 'Editar Universidad',
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nitController,
                      decoration: const InputDecoration(
                        labelText: 'NIT',
                        hintText: 'Ej: 123456789-0',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el NIT';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _nombreController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre de la universidad',
                        hintText: 'Ej: Universidad Central',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el nombre de la universidad';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _direccionController,
                      decoration: const InputDecoration(
                        labelText: 'Dirección',
                        hintText: 'Ej: Calle 123 #45-67, Ciudad',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese la dirección';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _telefonoController,
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        hintText: 'Ej: +57 1234567890',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese el teléfono';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _paginaWebController,
                      decoration: const InputDecoration(
                        labelText: 'Página web',
                        hintText: 'https://www.ejemplo.edu.co',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.language),
                      ),
                      keyboardType: TextInputType.url,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingrese la página web';
                        }
                        if (!_validarUrl(value)) {
                          return 'Ingrese una URL válida (http:// o https://)';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isLoading ? null : _guardarUniversidad,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            )
                          : Text(
                              widget.universidad == null
                                  ? 'Guardar Universidad'
                                  : 'Actualizar Universidad',
                            ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
