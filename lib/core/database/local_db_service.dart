import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/attendance/data/attendance_log_model.dart';
import '../../features/context/data/daily_context_model.dart';

class LocalDbService {
  // Singleton instance
  LocalDbService._internal();
  static final LocalDbService _instance = LocalDbService._internal();
  static LocalDbService get instance => _instance;

  late Isar _isar;

  Isar get isar => _isar;

  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [AttendanceLogSchema, DailyContextSchema],
      directory: dir.path,
    );
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }
}
