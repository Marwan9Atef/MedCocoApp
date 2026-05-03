import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/context_util.dart';
import 'package:medcoco/core/widget/desktop_refresh_indicator.dart';
import 'package:medcoco/core/widget/remove_container.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_cubit.dart';

import '../../../../core/widget/desktop_clear.dart';

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({super.key, required this.numberOfResults});
  final int numberOfResults;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search History", style: AppStyles.styleRegular36(context)),
            const SizedBox(height: 8),
            Text(
              "$numberOfResults result saved",
              style: AppStyles.styleRegular16(
                context,
              ).copyWith(color: AppColor.gray),
            ),
            const SizedBox(height: 8),
          ],
        ),
        Spacer(),
        context.screenWidth < 800
            ? RemoveContainer(
                onTap: () {
                  context.read<HistoryCubit>().clearHistory();
                },
              )
            : Row(
                children: [
                  DesktopRefreshIndicator(
                    onTap: () {
                      context.read<HistoryCubit>().getHistory();
                    },
                  ),
                  const SizedBox(width: 16),
                  DesktopClear(
                    onTap: () {
                      context.read<HistoryCubit>().clearHistory();
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
