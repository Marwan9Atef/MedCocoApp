import 'package:flutter/material.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/context_util.dart';
import 'package:valo/feature/search/presentation/screens/desktop/desktop_search_list.dart';
import 'package:valo/feature/search/presentation/screens/mobile/mobile_search_list.dart';
import '../../../../core/dummy/model/ray_model.dart';
import '../../../../core/theme/search_delgate_theme.dart';


class UploadSearch extends SearchDelegate {

  @override
  String get searchFieldLabel => "search by keywords...";
  @override
  ThemeData appBarTheme(BuildContext context) {
    return SearchDelegateTheme.searchTheme;
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
      }, icon: const Icon(Icons.clear),color: AppColor.white,)


    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back,color: AppColor.white,),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<RayModel> searchBuildResults = RayModel.rayList
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return SearchView(searchBuildResults: searchBuildResults);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<RayModel> searchBuildResults = RayModel.rayList
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return SearchView(searchBuildResults: searchBuildResults);
  }
  
  
  
}

class SearchView extends StatelessWidget {
  const SearchView({
    super.key,
    required this.searchBuildResults,
  });

  final List<RayModel> searchBuildResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 16,bottom: 16),
                child: Text("Search Results",style: AppStyles.styleRegular36(context),),
              ),
              context.screenWidth<800? Expanded(child: MobileSearchList(searchBuildResults: searchBuildResults,)): Expanded(child: DesktopSearchList(searchBuildResults: searchBuildResults,)),


            ],

          ),
        )
    );
  }
}

