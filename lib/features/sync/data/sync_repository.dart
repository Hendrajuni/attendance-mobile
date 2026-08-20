import 'package:dio/dio.dart';
import 'package:isar/isar.dart';
import '../../../core/network/api_client.dart';
import '../../../core/database/local_db_service.dart';
import '../../attendance/data/attendance_log_model.dart';

class SyncRepository {
  final ApiClient _apiClient;
  final Isar _isar;

  SyncRepository({ApiClient? apiClient, Isar? isar})
      : _apiClient = apiClient ?? ApiClient(),
        _isar = isar ?? LocalDbService.instance.isar;

  Future<int> syncUnsentLogs() async {
    // 1. Query Isar for unsynced logs
    final unsyncedLogs = await _isar.attendanceLogs
        .filter()
        .isSyncedEqualTo(false)
        .findAll();

    if (unsyncedLogs.isEmpty) {
      return 0; // Nothing to sync
    }

    // 2. Map to JSON array
    final List<Map<String, dynamic>> payload = unsyncedLogs.map((log) {
      return {
        'id': log.id, // Include ID to identify the record in response if needed
        'timestamp': log.timestamp.toIso8601String(),
        'log_category': log.logCategory,
        'latitude': log.latitude,
        'longitude': log.longitude,
        'is_mock_location': log.isMockLocation,
        'photo_base64': log.photoBase64 ?? '',
        'notes': log.isMockLocation ? 'MOCK_LOCATION_DETECTED' : '',
      };
    }).toList();

    try {
      // 3. POST request to /api/mobile/sync/
      final response = await _apiClient.dio.post(
        '/attendance/api/mobile/sync/',
        data: payload,
      );

      // 4. On success, update the records in Isar
      if (response.statusCode == 200 || response.statusCode == 201) {
        final syncedIds = unsyncedLogs.map((log) => log.id).toList();
        
        await _isar.writeTxn(() async {
          final logsToUpdate = await _isar.attendanceLogs.getAll(syncedIds);
          for (var log in logsToUpdate) {
            if (log != null) {
              log.isSynced = true;
              await _isar.attendanceLogs.put(log);
            }
          }
        });

        return syncedIds.length;
      } else {
        throw Exception('Server returned ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw 'Koneksi ke server terputus (Timeout).';
      }
      throw 'Gagal terhubung ke server (Kode: ${e.response?.statusCode ?? "Unknown"}).';
    } catch (e) {
      throw 'Terjadi kesalahan tidak terduga saat sinkronisasi.';
    }
  }
}
