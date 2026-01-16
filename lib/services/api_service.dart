import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/config/api_config.dart';

class ApiService {
  final http.Client _client;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _client.get(
        Uri.parse('${ApiConfig.fullApiUrl}$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Error al obtener datos: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _client.post(
        Uri.parse('${ApiConfig.fullApiUrl}$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      final decodedBody = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return decodedBody;
      } else {
        final backendError = decodedBody['error'] ?? 'Error desconocido del servidor';
        throw Exception('Error al crear: $backendError');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> delete(String endpoint) async {
    try {
      final response = await _client.delete(
        Uri.parse('${ApiConfig.fullApiUrl}$endpoint'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Error al eliminar: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  void dispose() {
    _client.close();
  }
}
