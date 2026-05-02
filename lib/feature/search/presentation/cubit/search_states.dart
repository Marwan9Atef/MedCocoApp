import 'package:medcoco/feature/search/data/models/search_response_model.dart';

abstract class SearchStates {}

class SearchInitial extends SearchStates {}

class SearchLoading extends SearchStates {}

class SearchSuccess extends SearchStates {
  final SearchResponseModel result;

  SearchSuccess({required this.result});
}

class SearchFailure extends SearchStates {
  final String error;

  SearchFailure({required this.error});
}
