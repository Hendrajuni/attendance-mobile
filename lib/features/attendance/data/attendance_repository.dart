import 'package:isar/isar.dart';
import '../../../core/database/local_db_service.dart';
import 'attendance_log_model.dart';

class AttendanceRepository {
  final LocalDbService _localDbService;

  AttendanceRepository({LocalDbService? localDbService})
      : _localDbService = localDbService ?? LocalDbService.instance;

  Future<void> saveAttendanceLog({
    required String logCategory,
    required double lat,
    required double lng,
    required bool isMock,
    required String? base64Photo,
  }) async {
    final log = AttendanceLog()
      ..timestamp = DateTime.now()
      ..logCategory = logCategory
      ..latitude = lat
      ..longitude = lng
      ..isMockLocation = isMock
      ..photoBase64 = base64Photo
      ..isSynced = false;

    final isar = _localDbService.isar;
    await isar.writeTxn(() async {
      await isar.attendanceLogs.put(log);
    });
  }

  Future<List<AttendanceLog>> getUnsyncedLogs() async {
    final isar = _localDbService.isar;
    return await isar.attendanceLogs.filter().isSyncedEqualTo(false).findAll();
  }

  Future<void> markAsSynced(List<Id> ids) async {
    final isar = _localDbService.isar;
    await isar.writeTxn(() async {
      final logs = await isar.attendanceLogs.getAll(ids);
      for (var log in logs) {
        if (log != null) {
          log.isSynced = true;
          await isar.attendanceLogs.put(log);
        }
      }
    });
  }

  Future<List<AttendanceLog>> getTodayLogs() async {
    final isar = _localDbService.isar;
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return await isar.attendanceLogs
        .filter()
        .timestampBetween(startOfDay, endOfDay)
        .sortByTimestamp()
        .findAll();
  }
}
