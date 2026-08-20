import 'package:isar/isar.dart';

part 'attendance_log_model.g.dart';

@collection
class AttendanceLog {
  Id id = Isar.autoIncrement;

  late DateTime timestamp;

  late String logCategory;

  late double latitude;

  late double longitude;

  late bool isMockLocation;

  String? photoBase64;

  bool isSynced = false;
}
