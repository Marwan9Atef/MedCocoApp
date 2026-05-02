import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/presentation/widgets/desktop_search_image.dart';
import '../../../../../core/generated/assets.dart';
import '../../../../../core/routes/route_center.dart';

class DesktopSearchItem extends StatelessWidget {
  const DesktopSearchItem({super.key, required this.searchModel});
  final SearchResultModel searchModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xff18181B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DesktopSearchImage(
            imagePath: searchModel.fileUrl,
            confidence: searchModel.similarityScore,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  searchModel.caption,
                  style: AppStyles.styleRegular20(context),
                ),

                const SizedBox(height: 15),
                IntrinsicWidth(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {
                          context.push(
                            RouteCenter.fullScreenImage,
                            extra: searchModel.fileUrl,
                          );
                        },
                        mouseCursor: SystemMouseCursors.click,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.imagesDetailsSvg,
                                fit: BoxFit.scaleDown,
                                height: 16,
                                width: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "View Details",
                                style: AppStyles.styleRegular14(
                                  context,
                                ).copyWith(color: AppColor.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
