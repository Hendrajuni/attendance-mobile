import 'package:flutter/foundation.dart';

@immutable
sealed class AttendanceEvent {}

class SubmitAttendanceRequested extends AttendanceEvent {
  final String logCategory;
  final String? base64Photo;

  SubmitAttendanceRequested(this.logCategory, this.base64Photo);
}
