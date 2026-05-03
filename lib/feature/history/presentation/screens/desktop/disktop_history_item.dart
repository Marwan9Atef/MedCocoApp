import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/widget/confidence_item.dart';
import 'package:medcoco/core/widget/remove_container.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_cubit.dart';
import 'package:medcoco/feature/history/presentation/widgets/history_desktop_image.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import '../../../../../core/generated/assets.dart';

class DesktopHistoryItem extends StatelessWidget {
  const DesktopHistoryItem({super.key, required this.result});
  final SearchResultModel result;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xff18181B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HistoryDesktopImage(
            imagePath: result.fileUrl,
        
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(result.caption, style: AppStyles.styleRegular20(context)),
                const SizedBox(height: 15),
                Text(result.cachedAt, style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray)),
                const SizedBox(height: 15),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.push(
                          RouteCenter.fullScreenImage,
                          extra: result.fileUrl,
                        );
                      },
                      mouseCursor: SystemMouseCursors.click,
                      child: SvgPicture.asset(
                        AppAssets.detailsContainer,
                        fit: BoxFit.scaleDown,
                        height: 36,
                        width: 36,
                      ),
                    ),
                    const SizedBox(width: 12),
                    RemoveContainer(
                      onTap: () {
                        context
                            .read<HistoryCubit>()
                            .removeHistoryResult(result.imageId);
                      },
                    ),
                    const SizedBox(width: 12),
                    ConfidenceItem(
                      confidence: result.similarityScore,
                      isDesktop: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
