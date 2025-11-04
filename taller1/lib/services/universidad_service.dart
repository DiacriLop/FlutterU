import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/universidad.dart';

class UniversidadService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = 'universidades';

  // Obtener todas las universidades
  Stream<List<Universidad>> getUniversidades() {
    return _firestore
        .collection(_collectionName)
        .orderBy('nombre')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Universidad.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  // Obtener una universidad por su ID
  Future<Universidad?> getUniversidadById(String id) async {
    try {
      final doc = await _firestore.collection(_collectionName).doc(id).get();
      if (doc.exists) {
        return Universidad.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      throw Exception('Error al obtener la universidad: $e');
    }
  }

  // Crear una nueva universidad
  Future<void> crearUniversidad(Universidad universidad) async {
    try {
      await _firestore
          .collection(_collectionName)
          .add(universidad.toFirestore());
    } catch (e) {
      throw Exception('Error al crear la universidad: $e');
    }
  }

  // Actualizar una universidad existente
  Future<void> actualizarUniversidad(Universidad universidad) async {
    try {
      if (universidad.id == null) {
        throw Exception('No se puede actualizar una universidad sin ID');
      }
      await _firestore
          .collection(_collectionName)
          .doc(universidad.id)
          .update(universidad.toFirestore());
    } catch (e) {
      throw Exception('Error al actualizar la universidad: $e');
    }
  }

  // Eliminar una universidad
  Future<void> eliminarUniversidad(String id) async {
    try {
      await _firestore.collection(_collectionName).doc(id).delete();
    } catch (e) {
      throw Exception('Error al eliminar la universidad: $e');
    }
  }
}
