import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/context_util.dart';
import 'package:medcoco/core/widget/remove_container.dart';


import '../../../../core/widget/desktop_clear.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("Search History",style: AppStyles.styleRegular36(context),),
        Spacer(),
        context.screenWidth<800?RemoveContainer(
          onTap: (){



          },

        ): DesktopClear(

          onTap: (){},
        ),

      ],
    );
  }
}
