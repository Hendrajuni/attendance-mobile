import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import '../../data/context_repository.dart';
import '../../data/daily_context_model.dart';
import '../../../../core/database/local_db_service.dart';
import 'context_event.dart';
import 'context_state.dart';

class ContextBloc extends Bloc<ContextEvent, ContextState> {
  final ContextRepository _contextRepository;
  final LocalDbService _localDbService;

  ContextBloc({ContextRepository? contextRepository, LocalDbService? localDbService})
      : _contextRepository = contextRepository ?? ContextRepository(),
        _localDbService = localDbService ?? LocalDbService.instance,
        super(ContextInitial()) {
    on<FetchContextRequested>(_onFetchContextRequested);
  }

  Future<void> _onFetchContextRequested(FetchContextRequested event, Emitter<ContextState> emit) async {
    emit(ContextLoading());
    try {
      await _contextRepository.fetchAndSaveContext();
      
      final isar = _localDbService.isar;
      final dailyContext = await isar.dailyContexts.get(1);
      
      if (dailyContext != null) {
        emit(ContextSuccess(dailyContext));
      } else {
        emit(ContextFailure('Context not found in local database after fetching.'));
      }
    } catch (e) {
      emit(ContextFailure(e.toString()));
    }
  }
}
