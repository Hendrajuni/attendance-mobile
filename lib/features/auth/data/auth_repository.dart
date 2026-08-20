import '../../../core/network/api_client.dart';
import '../../../core/services/secure_storage_service.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorageService _secureStorageService;

  AuthRepository({ApiClient? apiClient, SecureStorageService? secureStorageService})
      : _apiClient = apiClient ?? ApiClient(),
        _secureStorageService = secureStorageService ?? SecureStorageService();

  Future<void> login(String username, String password) async {
    try {
      final response = await _apiClient.dio.post(
        '/api/token/',
        data: {
          'username': username,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        // Backend custom endpoint returns {"token": "eyJhb..."}
        if (data != null && data['token'] != null) {
          await _secureStorageService.saveToken(data['token']);
        } else {
          throw Exception('Token not found in response');
        }
      } else {
        throw Exception('Login failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
