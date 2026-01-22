import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentConfig {
  static String get apiBaseUrl => dotenv.env['API_BASE_URL'] ?? '';

  static Future<void> load() async {
    await dotenv.load(fileName: ".env");
  }

  static bool validate() {
    return apiBaseUrl.isNotEmpty;
  }
}