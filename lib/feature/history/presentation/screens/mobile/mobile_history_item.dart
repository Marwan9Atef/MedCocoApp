import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_cubit.dart';
import 'package:medcoco/feature/history/presentation/widgets/history_mobile_image.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import '../../../../../core/theme/app_style.dart';

class MobileHistoryItem extends StatelessWidget {
  const MobileHistoryItem({super.key, required this.result});
  final SearchResultModel result;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xff18181B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HistoryMobileImage(
            imagePath: result.fileUrl,
            confidence: result.similarityScore,
            onRemove: () {
              context.read<HistoryCubit>().removeHistoryResult(result.imageId);
            },
          ),
          const SizedBox(height: 10),
          Text(result.caption, style: AppStyles.styleRegular20(context)),
          const SizedBox(height: 10),
          Text(result.cachedAt, style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray)),
        ],
      ),
    );
  }
}
