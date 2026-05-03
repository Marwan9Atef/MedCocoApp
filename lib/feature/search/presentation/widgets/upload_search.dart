import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/app_snack_bars.dart';
import 'package:medcoco/core/utils/context_util.dart';
import 'package:medcoco/core/widget/advance_loading_indicator.dart';
import 'package:medcoco/feature/search/data/models/search_request_model.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/presentation/cubit/search_cubit.dart';
import 'package:medcoco/feature/search/presentation/cubit/search_states.dart';
import 'package:medcoco/feature/search/presentation/screens/desktop/desktop_search_list.dart';
import 'package:medcoco/feature/search/presentation/screens/mobile/mobile_search_list.dart';
import 'package:medcoco/feature/search/presentation/widgets/search_input_dialog.dart';
import '../../../../core/theme/search_delgate_theme.dart';

class UploadSearch extends SearchDelegate {
  final SearchCubit searchCubit;
  int? _resultLimit;

  UploadSearch({required this.searchCubit}) {
    searchCubit.reset();
  }

  @override
  String get searchFieldLabel => "search by keywords...";
  @override
  ThemeData appBarTheme(BuildContext context) {
    return SearchDelegateTheme.searchTheme;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
        color: AppColor.white,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back, color: AppColor.white),
    );
  }

  @override
  void showResults(BuildContext context) {
    if (query.isEmpty) {
      AppSnackBars.showErrorSnackBar(
        context: context,
        message: "Please enter a search query",
      );
      return;
    }

    if (_resultLimit == null) {
      showDialog<int>(
        context: context,
        builder: (context) => const SearchInputDialog(),
      ).then((number) {
        if (number != null) {
          _resultLimit = number;
          if (context.mounted) {
            searchCubit.reset();
            searchCubit.search(SearchRequestModel(query: query, topK: number));
            super.showResults(context);
          }
          _resultLimit = null;
        }
      });
    } else {
      super.showResults(context);
      _resultLimit = null;
    }
  }

  @override
  Widget buildResults(BuildContext context) {
    return BlocProvider.value(
      value: searchCubit,
      child: BlocBuilder<SearchCubit, SearchStates>(
        builder: (context, state) {
          if (state is SearchSuccess) {
            final List<SearchResultModel> filteredResults =
                state.result.results;

            return SearchView(searchBuildResults: filteredResults);
          } else if (state is SearchLoading) {
            return const Center(child: AdvanceLoadingIndicator());
          } else {
            return Center(
              child: Text(
                "No results found",
                style: AppStyles.styleRegular16(context),
              ),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search,
            size: 64,
            color: AppColor.gray.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 24),
          Text(
            "Start typing to search",
            style: AppStyles.styleRegular18(
              context,
            ).copyWith(color: AppColor.gray),
          ),
          const SizedBox(height: 8),
          Text(
            "Search by keywords to find your medical images",
            style: AppStyles.styleRegular14(context),
          ),
        ],
      ),
    );
  }
}

class SearchView extends StatelessWidget {
  const SearchView({super.key, required this.searchBuildResults});

  final List<SearchResultModel> searchBuildResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Text(
                "Search Results",
                style: AppStyles.styleRegular36(context),
              ),
            ),
            context.screenWidth < 800
                ? Expanded(
                    child: MobileSearchList(
                      searchBuildResults: searchBuildResults,
                    ),
                  )
                : Expanded(
                    child: DesktopSearchList(
                      searchBuildResults: searchBuildResults,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
