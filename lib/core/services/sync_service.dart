import 'package:dio/dio.dart';
import '../../features/attendance/data/attendance_repository.dart';
import '../network/api_client.dart';

class SyncService {
  final AttendanceRepository _attendanceRepository;
  final ApiClient _apiClient;

  SyncService({AttendanceRepository? attendanceRepository, ApiClient? apiClient})
      : _attendanceRepository = attendanceRepository ?? AttendanceRepository(),
        _apiClient = apiClient ?? ApiClient();

  Future<void> syncOfflineData() async {
    final unsyncedLogs = await _attendanceRepository.getUnsyncedLogs();
    
    if (unsyncedLogs.isEmpty) {
      return; // No data to sync
    }

    List<int> syncedIds = [];

    for (var log in unsyncedLogs) {
      try {
        final payload = {
          'timestamp': log.timestamp.toIso8601String(),
          'latitude': log.latitude,
          'longitude': log.longitude,
          'log_category': log.logCategory,
          'notes': log.isMockLocation ? 'MOCK_LOCATION_DETECTED' : '',
        };

        final response = await _apiClient.dio.post(
          '/attendance/api/mobile/sync/',
          data: payload,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          syncedIds.add(log.id);
        }
      } on DioException catch (e) {
        // Print or log the error for now, continue attempting other logs
        print('Sync error for log ${log.id}: ${e.message}');
      } catch (e) {
        print('Unknown error during sync: $e');
      }
    }

    if (syncedIds.isNotEmpty) {
      await _attendanceRepository.markAsSynced(syncedIds);
    }
  }

  Future<int> getUnsyncedCount() async {
    final logs = await _attendanceRepository.getUnsyncedLogs();
    return logs.length;
  }
}
