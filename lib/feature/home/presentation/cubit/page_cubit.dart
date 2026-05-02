import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<int> {
  PageCubit() : super(0);
  void setValue(int newValue) => emit(newValue);

  int _historyKey = 0;
  int get historyKey => _historyKey;

  void destroyHistory() {
    _historyKey++;
    emit(state);
  }

  void resetHistoryKey() {
    _historyKey = 0;
  }
}
