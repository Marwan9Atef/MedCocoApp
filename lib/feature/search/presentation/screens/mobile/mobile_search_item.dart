import 'package:flutter/material.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/presentation/widgets/mobile_search_image.dart';
import '../../../../../core/theme/app_style.dart';

class MobileSearchItem extends StatelessWidget {
  const MobileSearchItem({super.key, required this.resultModel});

  final SearchResultModel resultModel;

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
          MobileSearchImage(
              imagePath: resultModel.fileUrl, confidence: resultModel.similarityScore),
          const SizedBox(height: 10),
          Text(resultModel.caption, style: AppStyles.styleRegular20(context)),
        ],
      ),
    );
  }
}
