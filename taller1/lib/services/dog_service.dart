import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dog_model.dart';

class DogService {
  static const String _baseUrl = 'https://dog.ceo/api';

  Future<List<DogBreed>> getAllBreeds() async {
    print('📡 Estado: Cargando datos de razas...');
    
    try {
      final response = await http.get(Uri.parse('$_baseUrl/breeds/list/all'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> breeds = data['message'];
        
        List<DogBreed> dogBreeds = [];
        
        for (var entry in breeds.entries) {
          try {
            final breed = DogBreed.fromJson({'message': breeds}, entry.key);
            final imageUrl = await getBreedImage(entry.key);
            dogBreeds.add(DogBreed(
              name: breed.name,
              subBreeds: breed.subBreeds,
              imageUrl: imageUrl,
            ));
          } catch (e) {
            print('⚠️ Error al procesar raza ${entry.key}: $e');
          }
        }
        
        print('✅ Estado: Datos cargados correctamente (${dogBreeds.length} razas)');
        return dogBreeds;
      } else {
        throw Exception('Error de servidor: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Estado: Error al cargar las razas -> $e');
      throw Exception('Error de conexión: $e');
    }
  }

  Future<String> getBreedImage(String breed) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/breed/$breed/images/random')
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['message'];
      } else {
        print('⚠️ Error al cargar imagen de $breed: ${response.statusCode}');
        throw Exception('Error al cargar la imagen: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Error de red al cargar imagen de $breed: $e');
      throw Exception('Error de conexión: $e');
    }
  }
}