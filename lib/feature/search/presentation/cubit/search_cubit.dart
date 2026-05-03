import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/feature/search/data/models/search_request_model.dart';
import 'package:medcoco/feature/search/domain/repo/search_repo.dart';
import 'package:medcoco/feature/search/presentation/cubit/search_states.dart';

@injectable
class SearchCubit extends Cubit<SearchStates> {
  final SearchRepo _searchRepo;

  SearchCubit(this._searchRepo) : super(SearchInitial());

  Future<void> search(SearchRequestModel request) async {
    emit(SearchLoading());
    final result = await _searchRepo.search(request);
    result.fold(
      (failure) => emit(SearchFailure(error: failure.message)),
      (result) => emit(SearchSuccess(result: result)),
    );
  }

  void reset() {
    emit(SearchInitial());
  }
}
