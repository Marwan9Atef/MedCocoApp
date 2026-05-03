import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/core/constant/loacl_constant.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/data/service/local/search_local_medical_service.dart';

@LazySingleton(as: SearchLocalMedicalService)
class SearchHiveMedicalService implements SearchLocalMedicalService {
  static final Box<Map> _box = Hive.box<Map>(LoaclConstant.searchCacheBox);
  final String _key = LoaclConstant.searchResponseKey;

  @override
  Future<void> clearSearchResponse() async {
    try {
      await _box.delete(_key);
    } catch (exception) {
      throw LocalException(exception.toString());
    }
  }

  @override
  SearchResponseModel? getSearchResponse() {
    try {
      final cached = _box.get(_key);
      if (cached == null || cached['data'] == null) {
        return null;
      }

      final data = _deepCastMap(cached['data'] as Map);
      return SearchResponseModel.fromJson(data);
    } catch (exception) {
      throw LocalException(exception.toString());
    }
  }

  @override
  Future<void> saveSearchResponse({
    required SearchResponseModel searchResponse,
  }) async {
    try {
      await _box.put(_key, {
        'time': DateTime.now().millisecondsSinceEpoch,
        'data': searchResponse.toJson(),
      });
    } catch (exception) {
      throw LocalException(exception.toString());
    }
  }

  Map<String, dynamic> _deepCastMap(Map map) {
    return map.map(
      (key, value) => MapEntry(
        key.toString(),
        value is Map
            ? _deepCastMap(value)
            : value is List
                ? value.map((e) => e is Map ? _deepCastMap(e) : e).toList()
                : value,
      ),
    );
  }
}
