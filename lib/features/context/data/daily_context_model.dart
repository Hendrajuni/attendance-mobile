import 'package:isar/isar.dart';

part 'daily_context_model.g.dart';

@collection
class DailyContext {
  Id id = 1;

  late DateTime date;

  late double allowedLat;

  late double allowedLng;

  late double radius;

  late String shiftName;

  late String shiftIn;

  late String shiftOut;

  String? serverClockIn;

  String? serverClockOut;
  String? serverCp1;
  String? serverIstirahat;
  String? serverCp2;

  late String employeeName;

  List<String> validButtons = [];
}
