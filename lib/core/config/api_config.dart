import 'package:polizas/core/config/environment_config.dart';

class ApiConfig {
  static String baseUrl = EnvironmentConfig.apiBaseUrl;
  static const String apiPath = '/policy/api';

  static String get fullApiUrl => '$baseUrl$apiPath';

  // Endpoints
  static const String automovil = '/vehicle';
  static const String seguro = '/insurance';

  static String seguroById(String id) => '$seguro/$id';
}
