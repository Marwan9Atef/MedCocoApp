import 'package:flutter/material.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'mobile_search_item.dart';

class MobileSearchList extends StatelessWidget {
  const MobileSearchList({super.key, required this.searchBuildResults});
  final List<SearchResultModel> searchBuildResults;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          MobileSearchItem(resultModel: searchBuildResults[index]),
      itemCount: searchBuildResults.length,
      separatorBuilder: (context, index) => const SizedBox(height: 17),
    );
  }
}
