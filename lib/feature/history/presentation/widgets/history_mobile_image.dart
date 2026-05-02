import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/core/widget/confidence_item.dart';

class HistoryMobileImage extends StatelessWidget {
  const HistoryMobileImage({
    super.key,
    required this.imagePath,
   
  });

  final String imagePath;


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.passthrough,
        children: [
          InkWell(
            onTap: () {
              context.push(RouteCenter.fullScreenImage, extra: imagePath);
            },
            mouseCursor: SystemMouseCursors.click,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: (){

              },
          mouseCursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child:SvgPicture.asset(AppAssets.imagesRemoveIcon,width: 22,height: 22),
              ),
            ),
          ),
          Positioned(
                  top: 8,
            left: 8,
            child: ConfidenceItem(confidence: 101))
        ],
      ),
    );
  }
}
