import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/core/constant/loacl_constant.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/data/service/local/search_local_medical_service.dart';

@LazySingleton(as: SearchLocalMedicalService)
class SearchHiveMedicalService implements SearchLocalMedicalService {
  Box<Map> get _box => Hive.box<Map>(LoaclConstant.searchCacheBox);
  final String _key = LoaclConstant.searchResponseKey;

  @override
  Future<void> clearSearchResponse() async {
    try {
      await _box.delete(_key);
      await _box.flush();
    } catch (exception) {
      throw LocalException(exception.toString());
    }
  }

  @override
  SearchResponseModel? getSearchResponse() {
    try {
      final cached = _box.get(_key);
      return _searchResponseFromCache(cached);
    } catch (exception) {
      throw LocalException(exception.toString());
    }
  }

  @override
  Future<void> saveSearchResponse({
    required SearchResponseModel searchResponse,
  }) async {
    try {
      final cachedAt = DateTime.now();
      final cachedSearchResponse = searchResponse.copyWith(
        results: searchResponse.results
            .map((result) => result.copyWith(cachedAt: _formatDate(cachedAt)))
            .toList(),
      );

      await _box.delete(_key);
      await _box.put(_key, {
        'time': cachedAt.millisecondsSinceEpoch,
        'data': cachedSearchResponse.toJson(),
      });
      await _box.flush();
    } catch (exception) {
      throw LocalException(exception.toString());
    }
  }

  @override
  Future<SearchResponseModel?> removeSearchResult(String imageId) async {
    try {
      final cached = _box.get(_key);
      final current = _searchResponseFromCache(cached);
      if (current == null) {
        return null;
      }

      final updatedResults = current.results
          .where((result) => result.imageId != imageId)
          .toList();

      if (updatedResults.isEmpty) {
        await _box.delete(_key);
        return current.copyWith(count: 0, results: const []);
      }

      final updatedHistory = current.copyWith(
        count: updatedResults.length,
        results: updatedResults,
      );
      await _box.put(_key, {
        'time': cached?['time'] ?? DateTime.now().millisecondsSinceEpoch,
        'data': updatedHistory.toJson(),
      });

      return updatedHistory;
    } catch (exception) {
      throw LocalException(exception.toString());
    }
  }

  SearchResponseModel? _searchResponseFromCache(Map? cached) {
    if (cached == null || cached['data'] == null) {
      return null;
    }

    final data = _deepCastMap(cached['data'] as Map);
    return SearchResponseModel.fromJson(data);
  }

  String _formatDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    return '$day/$month/${dateTime.year}';
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
