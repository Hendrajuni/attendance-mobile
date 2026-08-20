abstract class SyncState {}

class SyncInitial extends SyncState {}

class SyncInProgress extends SyncState {}

class SyncSuccess extends SyncState {
  final int count;
  SyncSuccess(this.count);
}

class SyncFailure extends SyncState {
  final String error;
  SyncFailure(this.error);
}
