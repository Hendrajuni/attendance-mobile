import 'package:dio/dio.dart';
import '../services/secure_storage_service.dart';

class ApiClient {
  late final Dio dio;
  final SecureStorageService _secureStorageService;

  ApiClient({SecureStorageService? secureStorageService}) 
      : _secureStorageService = secureStorageService ?? SecureStorageService() {
    dio = Dio(
      BaseOptions(
        // baseUrl: 'http://10.0.2.2:8000', // Localhost Android Emulator
        baseUrl: 'https://hr.pmgcloud.my.id', // Production VPS
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Asynchronously retrieve the token
          final token = await _secureStorageService.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Handle global errors here if needed
          return handler.next(e);
        },
      ),
    );
  }
}
