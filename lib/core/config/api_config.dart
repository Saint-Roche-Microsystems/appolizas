class ApiConfig {
  static const String baseUrl = 'https:/127.0.0.1:3000';
  static const String apiPath = '/poliza/api';

  static String get fullApiUrl => '$baseUrl$apiPath';

  // Endpoints
  static const String automovil = '/automovil';
  static const String seguro = '/seguro';

  static String seguroById(String id) => '$seguro/$id';
}
