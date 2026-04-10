import 'package:flutter/material.dart';
import 'package:valo/feature/upload/presentation/widgets/before_search_item.dart';
import 'package:valo/feature/search/presentation/widgets/upload_search.dart';

class BeforeSearch extends StatelessWidget {
  const BeforeSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () async {
          await showSearch(
              context: context,
              delegate: UploadSearch()
          );
        },
        child:const BeforeSearchItem() ,
      ),
    );
  }
}