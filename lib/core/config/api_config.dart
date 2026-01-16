class ApiConfig {
  static const String baseUrl = 'http://127.0.0.1:3000';
  static const String apiPath = '/poliza/api';

  static String get fullApiUrl => '$baseUrl$apiPath';

  // Endpoints
  static const String automovil = '/vehicle';
  static const String seguro = '/insurance';

  static String seguroById(String id) => '$seguro/$id';
}
