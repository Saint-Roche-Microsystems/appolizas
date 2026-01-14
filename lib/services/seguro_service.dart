import '../core/config/api_config.dart';
import '../models/seguro_model.dart';
import 'api_service.dart';

class SeguroService {
  final ApiService _apiService;

  SeguroService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<List<Seguro>> obtenerSeguros() async {
    final response = await _apiService.get(ApiConfig.seguro);

    if (response is List) {
      return response.map((json) => Seguro.fromJson(json)).toList();
    } else {
      throw Exception('Formato de respuesta inválido');
    }
  }

  Future<Seguro> obtenerSeguroPorId(String id) async {
    final response = await _apiService.get(ApiConfig.seguroById(id));
    return Seguro.fromJson(response);
  }

  Future<void> eliminarSeguro(String id) async {
    await _apiService.delete(ApiConfig.seguroById(id));
  }
}