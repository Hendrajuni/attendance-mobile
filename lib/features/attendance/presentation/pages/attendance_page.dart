import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../bloc/attendance_state.dart';

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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: state is AttendanceLoading
                            ? null
                            : () => _submitAttendance('MASUK'),
                        child: const Text('Absen Masuk (IN)'),
                      ),
                      ElevatedButton(
                        onPressed: state is AttendanceLoading
                            ? null
                            : () => _submitAttendance('PULANG'),
                        child: const Text('Absen Pulang (OUT)'),
                      ),
                    ],
                  ),
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
}
