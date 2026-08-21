import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';
import '../../../../core/database/local_db_service.dart';
import '../../../context/data/daily_context_model.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  CameraController? _cameraController;
  bool _isCameraInitialized = false;
  String _cameraError = '';

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        if (mounted) {
          setState(() {
            _cameraError = 'Tidak ada kamera yang tersedia di perangkat/emulator ini.';
          });
        }
        return;
      }

      final frontCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );

      _cameraController = CameraController(
        frontCamera,
        ResolutionPreset.medium,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      if (mounted) {
        setState(() {
          _isCameraInitialized = true;
        });
      }
    } catch (e) {
      debugPrint("Camera initialization error: $e");
      if (mounted) {
        setState(() {
          _cameraError = 'Error inisialisasi kamera. Pastikan emulator memiliki kamera.';
        });
      }
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _submitAttendance(String category) async {
    String base64Photo = "dummy_base64_photo_because_emulator_has_no_camera";

    if (_cameraError.isEmpty) {
      if (_cameraController == null || !_cameraController!.value.isInitialized) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Kamera belum siap')),
        );
        return;
      }
      
      try {
        final image = await _cameraController!.takePicture();
        final bytes = await image.readAsBytes();
        base64Photo = base64Encode(bytes);
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Gagal mengambil foto: $e')),
          );
        }
        return;
      }
    }

    if (mounted) {
      context.read<AttendanceBloc>().add(
        SubmitAttendanceRequested(category, base64Photo),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Absensi Kamera')),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.pop(context);
          } else if (state is AttendanceFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              if (_cameraError.isNotEmpty)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(_cameraError, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
                  )
                )
              else if (_isCameraInitialized)
                Center(
                  child: CameraPreview(_cameraController!),
                )
              else
                const Center(child: CircularProgressIndicator()),
              
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildActionButtons(state),
                ),
              ),

              if (state is AttendanceLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
  Widget _buildActionButtons(AttendanceState state) {
    List<String> validButtons = ['CLOCK_IN', 'CLOCK_OUT'];
    try {
      final isar = LocalDbService.instance.isar;
      final dailyContext = isar.dailyContexts.getSync(1);
      if (dailyContext != null && dailyContext.validButtons.isNotEmpty) {
        validButtons = dailyContext.validButtons;
      }
    } catch (e) {
      debugPrint("Error reading validButtons from Isar: $e");
    }

    // Map each category to a display name and color
    Map<String, Map<String, dynamic>> btnConfig = {
      'CLOCK_IN': {'label': 'Masuk (IN)', 'color': Colors.blue},
      'CHECKPOINT_1': {'label': 'CP 1', 'color': Colors.purple},
      'ISTIRAHAT': {'label': 'Istirahat', 'color': Colors.orange},
      'CHECKPOINT_2': {'label': 'CP 2', 'color': Colors.purple},
      'CLOCK_OUT': {'label': 'Pulang (OUT)', 'color': Colors.teal},
    };

    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      alignment: WrapAlignment.center,
      children: validButtons.map((serverCategory) {
        String submitCategory = serverCategory;
        if (serverCategory == 'CLOCK_IN') submitCategory = 'MASUK';
        if (serverCategory == 'CLOCK_OUT') submitCategory = 'PULANG';

        final config = btnConfig[serverCategory] ?? {'label': serverCategory, 'color': Colors.grey};
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: config['color'],
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: state is AttendanceLoading
              ? null
              : () => _submitAttendance(submitCategory),
          child: Text(config['label'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        );
      }).toList(),
    );
  }
}
