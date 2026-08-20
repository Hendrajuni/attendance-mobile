import 'package:dio/dio.dart';
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
        if (data != null && data['token'] != null) {
          await _secureStorageService.saveToken(data['token']);
        } else {
          throw 'Token tidak ditemukan dari server';
        }
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response?.data is Map && e.response!.data.containsKey('detail')) {
          throw e.response!.data['detail']; // Extract message from Django
        }
        if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
           throw 'Koneksi ke server terputus (Timeout). Coba lagi.';
        }
        throw 'Gagal terhubung ke server (Kode: ${e.response?.statusCode ?? "Unknown"}).';
      }
      throw 'Terjadi kesalahan tidak terduga.';
    }
  }
}
