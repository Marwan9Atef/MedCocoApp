import 'package:flutter/cupertino.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';

import 'desktop_search_item.dart';

class DesktopSearchList extends StatelessWidget {
  const DesktopSearchList({super.key, required this.searchBuildResults});
  final List<SearchResultModel> searchBuildResults;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) =>
          DesktopSearchItem(searchModel: searchBuildResults[index]),
      itemCount: searchBuildResults.length,
    );
  }
}
