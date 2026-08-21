import 'package:isar/isar.dart';
import '../../../core/network/api_client.dart';
import '../../../core/database/local_db_service.dart';
import 'daily_context_model.dart';

class ContextRepository {
  final ApiClient _apiClient;
  final LocalDbService _localDbService;

  ContextRepository({ApiClient? apiClient, LocalDbService? localDbService})
      : _apiClient = apiClient ?? ApiClient(),
        _localDbService = localDbService ?? LocalDbService.instance;

  Future<void> fetchAndSaveContext() async {
    try {
      final response = await _apiClient.dio.get('/attendance/api/mobile/context/');
      
      if (response.statusCode == 200) {
        final data = response.data;
        final geofence = data['geofence'] ?? {};
        
        final dailyContext = DailyContext()
          ..id = 1
          ..date = DateTime.now()
          ..allowedLat = geofence['latitude']?.toDouble() ?? 0.0
          ..allowedLng = geofence['longitude']?.toDouble() ?? 0.0
          ..radius = geofence['allowed_radius']?.toDouble() ?? 1500.0
          ..shiftName = data['shift'] ?? 'Tidak Ada Jadwal'
          ..shiftIn = data['shift_in'] ?? '08:00'
          ..shiftOut = data['shift_out'] ?? '16:00'
          ..serverClockIn = data['today_clock_in']
          ..serverClockOut = data['today_clock_out']
          ..employeeName = data['name'] ?? 'Unknown'
          ..validButtons = (data['valid_buttons'] as List<dynamic>?)
              ?.map((e) => e['category'] as String)
              .toList() ?? [];

        final isar = _localDbService.isar;
        
        await isar.writeTxn(() async {
          await isar.dailyContexts.put(dailyContext);
        });
      } else {
        throw Exception('Failed to fetch context: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching context: $e');
    }
  }
}
