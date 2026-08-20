import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/sync_repository.dart';
import 'sync_event.dart';
import 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final SyncRepository _syncRepository;

  SyncBloc({SyncRepository? syncRepository})
      : _syncRepository = syncRepository ?? SyncRepository(),
        super(SyncInitial()) {
    on<SyncDataRequested>(_onSyncDataRequested);
  }

  Future<void> _onSyncDataRequested(SyncDataRequested event, Emitter<SyncState> emit) async {
    emit(SyncInProgress());
    try {
      final count = await _syncRepository.syncUnsentLogs();
      emit(SyncSuccess(count));
    } catch (e) {
      emit(SyncFailure(e.toString()));
    }
  }
}
