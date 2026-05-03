import 'package:medcoco/feature/search/data/models/search_response_model.dart';

abstract class HistoryStates {}

class HistoryInitial extends HistoryStates {}

class HistoryLoading extends HistoryStates {}

class HistoryEmpty extends HistoryStates {}

class HistorySuccess extends HistoryStates {
  final SearchResponseModel history;

  HistorySuccess({required this.history});
}

class HistoryFailure extends HistoryStates {
  final String error;

  HistoryFailure({required this.error});
}
