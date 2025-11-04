class Universidad {
  final String? id;
  final String nit;
  final String nombre;
  final String direccion;
  final String telefono;
  final String paginaWeb;

  Universidad({
    this.id,
    required this.nit,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.paginaWeb,
  });

  // Convertir un documento de Firestore a un objeto Universidad
  factory Universidad.fromFirestore(
      Map<String, dynamic> data, String id) {
    return Universidad(
      id: id,
      nit: data['nit'] ?? '',
      nombre: data['nombre'] ?? '',
      direccion: data['direccion'] ?? '',
      telefono: data['telefono'] ?? '',
      paginaWeb: data['pagina_web'] ?? '',
    );
  }

  // Convertir un objeto Universidad a un Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'nit': nit,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'pagina_web': paginaWeb,
    };
  }

  // Crear una copia de la universidad con algunos campos actualizados
  Universidad copyWith({
    String? id,
    String? nit,
    String? nombre,
    String? direccion,
    String? telefono,
    String? paginaWeb,
  }) {
    return Universidad(
      id: id ?? this.id,
      nit: nit ?? this.nit,
      nombre: nombre ?? this.nombre,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      paginaWeb: paginaWeb ?? this.paginaWeb,
    );
  }

  @override
  String toString() {
    return 'Universidad(id: $id, nit: $nit, nombre: $nombre, direccion: $direccion, telefono: $telefono, paginaWeb: $paginaWeb)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Universidad &&
      other.id == id &&
      other.nit == nit &&
      other.nombre == nombre &&
      other.direccion == direccion &&
      other.telefono == telefono &&
      other.paginaWeb == paginaWeb;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      nit.hashCode ^
      nombre.hashCode ^
      direccion.hashCode ^
      telefono.hashCode ^
      paginaWeb.hashCode;
  }
}
