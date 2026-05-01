import 'package:flutter/cupertino.dart';
import 'package:medcoco/core/dummy/model/ray_model.dart';

import 'desktop_search_item.dart';

class DesktopSearchList extends StatelessWidget {

  const DesktopSearchList({
    super.key,
    this.searchBuildResults=const[],


  });
  final List<RayModel> searchBuildResults;



  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context, index) => DesktopSearchItem(rayModel: searchBuildResults[index] ),itemCount:searchBuildResults.length,);
  }
}