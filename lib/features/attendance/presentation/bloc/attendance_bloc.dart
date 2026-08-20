import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/attendance_repository.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/database/local_db_service.dart';
import '../../../context/data/daily_context_model.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository _repository;
  final LocationService _locationService;
  final LocalDbService _localDbService;

  AttendanceBloc({
    AttendanceRepository? repository,
    LocationService? locationService,
    LocalDbService? localDbService,
  })  : _repository = repository ?? AttendanceRepository(),
        _locationService = locationService ?? LocationService(),
        _localDbService = localDbService ?? LocalDbService.instance,
        super(AttendanceInitial()) {
    on<SubmitAttendanceRequested>(_onSubmitAttendanceRequested);
  }

  Future<void> _onSubmitAttendanceRequested(
      SubmitAttendanceRequested event, Emitter<AttendanceState> emit) async {
    emit(AttendanceLoading());
    try {
      final position = await _locationService.getCurrentLocation();
      final lat = position.latitude;
      final lng = position.longitude;
      final isMock = position.isMocked;

      final isar = _localDbService.isar;
      final dailyContext = await isar.dailyContexts.get(1);

      if (dailyContext == null) {
        emit(AttendanceFailure("Data konteks harian (geofence) tidak ditemukan. Silakan buka Dashboard kembali."));
        return;
      }

      final distance = _locationService.calculateDistance(
          lat, lng, dailyContext.allowedLat, dailyContext.allowedLng);

      if (distance > dailyContext.radius) {
        emit(AttendanceFailure("Anda berada di luar radius absen."));
        return;
      }

      await _repository.saveAttendanceLog(
        logCategory: event.logCategory,
        lat: lat,
        lng: lng,
        isMock: isMock,
        base64Photo: event.base64Photo,
      );

      emit(AttendanceSuccess("Absen berhasil disimpan offline"));
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }
}
