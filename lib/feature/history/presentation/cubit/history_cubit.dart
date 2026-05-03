import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/feature/history/domain/repo/history_repo.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_states.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';

@injectable
class HistoryCubit extends Cubit<HistoryStates> {
  final HistoryRepo _historyRepo;

  HistoryCubit(this._historyRepo) : super(HistoryInitial());

  Future<void> getHistory() async {
    emit(HistoryLoading());

    final result = await _historyRepo.getSearchHistory();
    result.fold(
      (failure) => emit(HistoryFailure(error: failure.message)),
      _emitHistory,
    );
  }

  Future<void> clearHistory() async {
    final result = await _historyRepo.clearSearchHistory();
    result.fold(
      (failure) => emit(HistoryFailure(error: failure.message)),
      (_) => emit(HistoryEmpty()),
    );
  }

  Future<void> removeHistoryResult(String imageId) async {
    final result = await _historyRepo.removeSearchHistoryResult(imageId);
    result.fold(
      (failure) => emit(HistoryFailure(error: failure.message)),
      _emitHistory,
    );
  }

  void _emitHistory(SearchResponseModel? history) {
    if (history == null || history.results.isEmpty) {
      emit(HistoryEmpty());
      return;
    }

    emit(HistorySuccess(history: history));
  }
}
