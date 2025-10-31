import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthService {
  final String baseUrl = 'https://parking.visiontic.com.co/api';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        try {
          // Guardar token de forma segura con flutter_secure_storage
          if (data['token'] != null) {
            await _secureStorage.write(key: 'token', value: data['token']);
            await _secureStorage.write(key: 'token_type', value: data['type'] ?? 'bearer');
          }

          // Guardar datos del usuario con shared_preferences (no sensibles)
          if (data['user'] != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_name', data['user']['name']);
            await prefs.setString('user_email', data['user']['email']);
            await prefs.setInt('user_id', data['user']['id']);
          }

          return {
            'success': true,
            'user': data['user'] != null ? User.fromJson(data['user']) : null,
          };
        } catch (e) {
          debugPrint('Error al guardar credenciales: $e');
          return {
            'success': false,
            'message': 'Error al guardar credenciales localmente',
          };
        }
      }

      if (response.statusCode == 401) {
        return {
          'success': false,
          'message': data['message'] ?? 'Error en la autenticación.',
        };
      }

      return {
        'success': false,
        'message': data['message'] ?? 'Error desconocido en login',
      };
    } catch (e) {
      debugPrint('Exception en login: $e');
      return {
        'success': false,
        'message': 'Error de conexión. Verifica tu internet.',
      };
    }
  }

  Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getInt('user_id');
      final name = prefs.getString('user_name');
      final email = prefs.getString('user_email');

      if (id != null && name != null && email != null) {
        return User(id: id, name: name, email: email);
      }
    } catch (e) {
      debugPrint('Error al obtener usuario: $e');
    }
    return null;
  }

  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: 'token');
    } catch (e) {
      debugPrint('Error al obtener token: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      final token = await getToken();
      if (token != null) {
        await http.post(
          Uri.parse('$baseUrl/logout'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );
      }

      await _secureStorage.delete(key: 'token');
      await _secureStorage.delete(key: 'token_type');

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_id');
      await prefs.remove('user_name');
      await prefs.remove('user_email');
    } catch (e) {
      debugPrint('Logout error: $e');
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  Future<Map<String, String>> getAuthHeader() async {
    final token = await getToken();
    final tokenType = await _secureStorage.read(key: 'token_type') ?? 'bearer';

    if (token != null) {
      return {
        'Authorization': '${tokenType.substring(0, 1).toUpperCase()}${tokenType.substring(1)} $token',
        'Content-Type': 'application/json',
      };
    }
    return {'Content-Type': 'application/json'};
  }
}
