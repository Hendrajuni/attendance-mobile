import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/context_bloc.dart';
import '../bloc/context_event.dart';
import '../bloc/context_state.dart';

import '../../../attendance/presentation/pages/attendance_page.dart';
import '../../../attendance/presentation/bloc/attendance_bloc.dart';
import '../../../attendance/data/attendance_repository.dart';
import '../../../auth/presentation/pages/login_page.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../../../../core/database/local_db_service.dart';
import '../../../sync/presentation/bloc/sync_bloc.dart';
import '../../../sync/presentation/bloc/sync_event.dart';
import '../../../sync/presentation/bloc/sync_state.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();

  Widget _buildAttendanceStatus(ContextSuccess state, String displayClockIn, String displayClockOut, bool isLate) {
    bool is5x = state.contextData.validButtons.contains('ISTIRAHAT');
    
    if (is5x) {
      return Column(
        children: [
          _buildTimelineRow('Masuk', displayClockIn, isLate ? Colors.red : Colors.green),
          _buildTimelineRow('CP 1', state.contextData.serverCp1 ?? '--:--', Colors.blue),
          _buildTimelineRow('Istirahat', state.contextData.serverIstirahat ?? '--:--', Colors.orange),
          _buildTimelineRow('CP 2', state.contextData.serverCp2 ?? '--:--', Colors.blue),
          _buildTimelineRow('Pulang', displayClockOut, Colors.green),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Clock In
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Clock In', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(displayClockIn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: displayClockIn == '--:--' ? Colors.grey.withOpacity(0.1) : (isLate ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(displayClockIn == '--:--' ? 'Belum Absen' : (isLate ? 'Telat' : 'Tercatat'), style: TextStyle(color: displayClockIn == '--:--' ? Colors.grey : (isLate ? Colors.red : Colors.green), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          // Clock Out
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Clock Out', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(displayClockOut, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: displayClockOut == '--:--' ? Colors.grey.withOpacity(0.1) : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(displayClockOut == '--:--' ? 'Belum Absen' : 'Tercatat', style: TextStyle(color: displayClockOut == '--:--' ? Colors.grey : Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildTimelineRow(String label, String time, Color activeColor) {
    bool isRecorded = time != '--:--';
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Row(
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isRecorded ? activeColor.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(isRecorded ? 'Tercatat' : 'Belum', style: TextStyle(color: isRecorded ? activeColor : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0; // State untuk navigasi menu bawah
  String _clockIn = '--:--';
  String _clockOut = '--:--';
  int _unsyncedCount = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _fetchLocalData();
    context.read<ContextBloc>().add(FetchContextRequested());
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchLocalData() async {
    final repo = AttendanceRepository();
    
    final todayLogs = await repo.getTodayLogs();
    final unsyncedLogs = await repo.getUnsyncedLogs();
    final count = unsyncedLogs.length;
    
    String inTime = '--:--';
    String outTime = '--:--';
    
    if (todayLogs.isNotEmpty) {
      inTime = "${todayLogs.first.timestamp.hour.toString().padLeft(2, '0')}:${todayLogs.first.timestamp.minute.toString().padLeft(2, '0')}";
      if (todayLogs.length > 1) {
        outTime = "${todayLogs.last.timestamp.hour.toString().padLeft(2, '0')}:${todayLogs.last.timestamp.minute.toString().padLeft(2, '0')}";
      }
    }
    
    if (mounted) {
      setState(() {
        _clockIn = inTime;
        _clockOut = outTime;
        _unsyncedCount = count;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A3469),
        title: const Text('Petaling HR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              if (value == 'refresh') {
                context.read<ContextBloc>().add(FetchContextRequested());
              } else if (value == 'logout') {
                await SecureStorageService().deleteToken();
                final isar = LocalDbService.instance.isar;
                await isar.writeTxn(() async {
                  await isar.clear();
                });
                
                if (context.mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => AuthBloc(),
                        child: const LoginPage(),
                      ),
                    ),
                    (route) => false,
                  );
                }
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(value: 'refresh', child: Text('Refresh Data')),
              const PopupMenuItem(value: 'logout', child: Text('Logout / Ganti Akun')),
            ],
          ),
        ],
      ),
      body: _buildBodyContent(context),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 85, // Diubah dari 70 ke 85 untuk menghindari BOTTOM OVERFLOW
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildNavItem(icon: Icons.home, label: 'Beranda', index: 0),
              _buildNavItem(icon: Icons.history, label: 'Riwayat', index: 1),
              
              // Tombol Tengah (Sinkron)
              GestureDetector(
                onTap: () {
                   if (_unsyncedCount > 0) {
                     context.read<SyncBloc>().add(SyncDataRequested());
                   } else {
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Semua data sudah tersinkronisasi')));
                   }
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Transform.translate(
                      offset: const Offset(0, -15),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: _unsyncedCount > 0 ? Colors.red : const Color(0xFF1976D2),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: (_unsyncedCount > 0 ? Colors.red : Colors.blue).withOpacity(0.3), 
                                  blurRadius: 8, 
                                  offset: const Offset(0, 4)
                                ),
                              ],
                            ),
                            child: const Icon(Icons.cloud_sync, color: Colors.white, size: 32),
                          ),
                          if (_unsyncedCount > 0)
                            Positioned(
                              right: -5,
                              top: -5,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                                ),
                                child: Text(
                                  '$_unsyncedCount',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -8),
                      child: Text('Sinkron', style: TextStyle(color: _unsyncedCount > 0 ? Colors.red : const Color(0xFF1976D2), fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              ),

              _buildNavItem(icon: Icons.receipt_long, label: 'Slip Gaji', index: 2),
              _buildNavItem(icon: Icons.person_outline, label: 'Profil', index: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    bool isSelected = _selectedIndex == index;
    Color color = isSelected ? const Color(0xFF1976D2) : Colors.grey;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        color: Colors.transparent, // expand tap area
        padding: const EdgeInsets.only(bottom: 8.0, left: 16.0, right: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyContent(BuildContext context) {
    if (_selectedIndex != 0) {
      // Jika bukan di tab Beranda, tampilkan placeholder
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 60, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text('Menu Segera Hadir', style: TextStyle(fontSize: 18, color: Colors.grey[600])),
          ],
        ),
      );
    }

    return BlocConsumer<ContextBloc, ContextState>(
      listener: (context, state) {
        if (state is ContextFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      builder: (context, state) {
        if (state is ContextLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ContextFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 60),
                  const SizedBox(height: 16),
                  Text('Gagal memuat konteks harian:\n${state.error}', textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => context.read<ContextBloc>().add(FetchContextRequested()),
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A3469)),
                    child: const Text('Coba Lagi', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        } else if (state is ContextSuccess) {
          return _buildDashboardContent(context, state);
        }
        return const Center(child: Text('Memulai...'));
      },
    );
  }

  Widget _buildDashboardContent(BuildContext context, ContextSuccess state) {
    bool hasOfflineData = _unsyncedCount > 0;
    
    String displayClockIn = state.contextData.serverClockIn ?? _clockIn;
    String displayClockOut = state.contextData.serverClockOut ?? _clockOut;
    
    // Calculate Late Status
    bool isLate = false;
    if (displayClockIn != '--:--' && state.contextData.shiftName != 'Tidak Ada Jadwal') {
      if (displayClockIn.compareTo(state.contextData.shiftIn) > 0) {
        isLate = true;
      }
    }
    
    // Calculate Working Hours dynamically
    String workingHoursStr = '0j 0m';
    String expectedHoursStr = '8j';
    double progress = 0.0;
    
    try {
      final now = DateTime.now();
      
      // Target hours
      final shiftInParts = state.contextData.shiftIn.split(':');
      final shiftOutParts = state.contextData.shiftOut.split(':');
      final sIn = DateTime(now.year, now.month, now.day, int.parse(shiftInParts[0]), int.parse(shiftInParts[1]));
      final sOut = DateTime(now.year, now.month, now.day, int.parse(shiftOutParts[0]), int.parse(shiftOutParts[1]));
      
      final expectedDuration = sOut.difference(sIn);
      int expectedHours = expectedDuration.inHours;
      if (expectedHours <= 0) expectedHours = 8;
      expectedHoursStr = '${expectedHours}j';
      
      if (displayClockIn != '--:--') {
        final inParts = displayClockIn.split(':');
        final inTime = DateTime(now.year, now.month, now.day, int.parse(inParts[0]), int.parse(inParts[1]));
        
        DateTime outTime;
        if (displayClockOut != '--:--') {
          final outParts = displayClockOut.split(':');
          outTime = DateTime(now.year, now.month, now.day, int.parse(outParts[0]), int.parse(outParts[1]));
        } else {
          outTime = now;
        }
        
        final duration = outTime.difference(inTime);
        int hours = duration.inHours;
        int minutes = duration.inMinutes.remainder(60);
        
        if (hours < 0) hours = 0;
        if (minutes < 0) minutes = 0;
        
        workingHoursStr = '${hours}j ${minutes}m';
        progress = duration.inMinutes / expectedDuration.inMinutes;
        if (progress > 1.0) progress = 1.0;
        if (progress < 0.0) progress = 0.0;
      }
    } catch (e) {
      // Ignored
    }

    return RefreshIndicator(
      onRefresh: () async {
        await _fetchLocalData();
        context.read<ContextBloc>().add(FetchContextRequested());
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header / Hero Section (New Design)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 24.0, left: 24.0, right: 24.0, bottom: 40.0),
              decoration: const BoxDecoration(
                color: Color(0xFF1565C0), // Biru korporat
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.lightBlueAccent.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: const Icon(Icons.person, color: Colors.white, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Selamat Siang', style: TextStyle(color: Colors.white70, fontSize: 14)),
                              Text(state.contextData.employeeName, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            const Icon(Icons.notifications_none, color: Colors.white),
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // White Card "Hari Ini"
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 5)),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Card Header
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                                const SizedBox(width: 8),
                                const Text('Hari Ini', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              ],
                            ),
                            Text("${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}", style: const TextStyle(color: Colors.grey, fontSize: 14)),
                          ],
                        ),
                        const SizedBox(height: 24),
                        
                        // Card Body (Clock In / Out)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Clock In
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Clock In', style: TextStyle(color: Colors.grey, fontSize: 14)),
                                const SizedBox(height: 4),
                                Text(displayClockIn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                const SizedBox(height: 4),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: displayClockIn == '--:--' ? Colors.grey.withOpacity(0.1) : (isLate ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(displayClockIn == '--:--' ? 'Belum Absen' : (isLate ? 'Telat' : 'Tercatat'), style: TextStyle(color: displayClockIn == '--:--' ? Colors.grey : (isLate ? Colors.red : Colors.green), fontSize: 12, fontWeight: FontWeight.bold)),
                                  ),
                              ],
                            ),
                            // Clock Out
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Clock Out', style: TextStyle(color: Colors.grey, fontSize: 14)),
                                const SizedBox(height: 4),
                                Text(displayClockOut, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: displayClockOut == '--:--' ? Colors.grey.withOpacity(0.1) : Colors.green.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(displayClockOut == '--:--' ? 'Belum Absen' : 'Tercatat', style: TextStyle(color: displayClockOut == '--:--' ? Colors.grey : Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            // Action Button
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider(
                                      create: (_) => AttendanceBloc(),
                                      child: const AttendancePage(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
                                  ],
                                ),
                                child: const Icon(Icons.face_retouching_natural, color: Colors.white, size: 36),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 24),
                        // Progress Bar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Jam Kerja', style: TextStyle(color: Colors.grey, fontSize: 14)),
                            RichText(
                              text: TextSpan(
                                style: const TextStyle(color: Colors.black, fontSize: 14),
                                children: [
                                  TextSpan(text: '$workingHoursStr ', style: const TextStyle(fontWeight: FontWeight.bold)),
                                  TextSpan(text: '/ $expectedHoursStr', style: const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[200],
                            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
                            minHeight: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Notifikasi Sinkronisasi (Merah = Offline/Ada data, Hijau = Online/Sinkron)
            BlocConsumer<SyncBloc, SyncState>(
              listener: (context, syncState) {
                if (syncState is SyncSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Berhasil menyinkronkan ${syncState.count} data!'), backgroundColor: Colors.green),
                  );
                  _fetchLocalData(); // Refresh UI to show 0 unsynced
                  context.read<ContextBloc>().add(FetchContextRequested()); // Force refresh context to get server logs
                }
              },
              builder: (context, syncState) {
                bool isSyncing = syncState is SyncInProgress;
                bool syncFailed = syncState is SyncFailure;
                
                // Jika sedang sync atau gagal sync, override warna
                Color bannerColor = hasOfflineData ? Colors.red : Colors.green;
                IconData bannerIcon = hasOfflineData ? Icons.cloud_off : Icons.cloud_done;
                String bannerText = hasOfflineData 
                    ? 'Offline: $_unsyncedCount Absensi menunggu sinkron' 
                    : 'Online: Semua data tersinkronisasi';

                if (syncFailed) {
                  bannerColor = Colors.orange;
                  bannerIcon = Icons.error_outline;
                  bannerText = 'Gagal sinkronisasi. Tap untuk coba lagi.';
                }

                return GestureDetector(
                  onTap: hasOfflineData && !isSyncing ? () {
                    context.read<SyncBloc>().add(SyncDataRequested());
                  } : null,
                  child: Container(
                    margin: const EdgeInsets.all(24),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: bannerColor.withOpacity(0.1),
                      border: Border.all(color: bannerColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        if (isSyncing)
                          const SizedBox(
                            width: 24, 
                            height: 24, 
                            child: CircularProgressIndicator(strokeWidth: 2)
                          )
                        else
                          Icon(bannerIcon, color: bannerColor),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            isSyncing ? 'Menyinkronkan data...' : bannerText,
                            style: TextStyle(
                              color: bannerColor,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        if (hasOfflineData && !isSyncing && !syncFailed)
                          const Text(
                            'Sinkron', 
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)
                          ),
                      ],
                    ),
                  ),
                );
              }
            ),
            
            // Menu Grid
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Text('Jelajahi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                    context,
                    title: 'Slip Gaji',
                    icon: Icons.payments,
                    color: Colors.blue,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Slip Gaji (Segera Hadir)')));
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Tugas',
                    icon: Icons.assignment,
                    color: Colors.orange,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Menu Tugas (Segera Hadir)')));
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Pengumuman',
                    icon: Icons.campaign,
                    color: Colors.teal,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengumuman (Segera Hadir)')));
                    },
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Pengaturan',
                    icon: Icons.settings,
                    color: Colors.blueGrey,
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pengaturan (Segera Hadir)')));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required IconData icon, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceStatus(ContextSuccess state, String displayClockIn, String displayClockOut, bool isLate) {
    bool is5x = state.contextData.validButtons.contains('ISTIRAHAT');
    
    if (is5x) {
      return Column(
        children: [
          _buildTimelineRow('Masuk', displayClockIn, isLate ? Colors.red : Colors.green),
          _buildTimelineRow('CP 1', state.contextData.serverCp1 ?? '--:--', Colors.blue),
          _buildTimelineRow('Istirahat', state.contextData.serverIstirahat ?? '--:--', Colors.orange),
          _buildTimelineRow('CP 2', state.contextData.serverCp2 ?? '--:--', Colors.blue),
          _buildTimelineRow('Pulang', displayClockOut, Colors.green),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Clock In
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Clock In', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(displayClockIn, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: displayClockIn == '--:--' ? Colors.grey.withOpacity(0.1) : (isLate ? Colors.red.withOpacity(0.2) : Colors.green.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(displayClockIn == '--:--' ? 'Belum Absen' : (isLate ? 'Telat' : 'Tercatat'), style: TextStyle(color: displayClockIn == '--:--' ? Colors.grey : (isLate ? Colors.red : Colors.green), fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          // Clock Out
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Clock Out', style: TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(displayClockOut, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: displayClockOut == '--:--' ? Colors.grey.withOpacity(0.1) : Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(displayClockOut == '--:--' ? 'Belum Absen' : 'Tercatat', style: TextStyle(color: displayClockOut == '--:--' ? Colors.grey : Colors.green, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildTimelineRow(String label, String time, Color activeColor) {
    bool isRecorded = time != '--:--';
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Row(
            children: [
              Text(time, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isRecorded ? activeColor.withOpacity(0.2) : Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(isRecorded ? 'Tercatat' : 'Belum', style: TextStyle(color: isRecorded ? activeColor : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
