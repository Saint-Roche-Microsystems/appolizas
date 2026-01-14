import '../core/config/api_config.dart';
import '../models/automovil_model.dart';
import 'api_service.dart';

class AutomovilService {
  final ApiService _apiService;

  AutomovilService({ApiService? apiService})
      : _apiService = apiService ?? ApiService();

  Future<Automovil> crearAutomovil(Automovil automovil) async {
    final response = await _apiService.post(
      ApiConfig.automovil,
      automovil.toJson(),
    );
    return Automovil.fromJson(response);
  }
}