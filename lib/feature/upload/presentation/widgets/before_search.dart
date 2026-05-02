import 'package:flutter/material.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/feature/search/presentation/cubit/search_cubit.dart';
import 'package:medcoco/feature/upload/presentation/widgets/before_search_item.dart';
import 'package:medcoco/feature/search/presentation/widgets/upload_search.dart';

class BeforeSearch extends StatelessWidget {
  const BeforeSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          await showSearch(
            context: context,
            delegate: UploadSearch(searchCubit: serviceLocator<SearchCubit>()),
          );
        },
        child: const BeforeSearchItem(),
      ),
    );
  }
}
