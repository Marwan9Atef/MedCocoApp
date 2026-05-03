import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/core/widget/confidence_item.dart';
import 'package:medcoco/core/widget/simple_loading_indicator.dart';

class HistoryMobileImage extends StatelessWidget {
  const HistoryMobileImage({
    super.key,
    required this.imagePath,
    required this.confidence,
    required this.onRemove,
  });

  final String imagePath;
  final double confidence;
  final VoidCallback onRemove;

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
            child: CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) =>
                  const Center(child: SimpleLoadingIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.broken_image, size: 48)),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: InkWell(
              onTap: onRemove,
              mouseCursor: SystemMouseCursors.click,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.asset(
                  AppAssets.imagesRemoveIcon,
                  width: 22,
                  height: 22,
                ),
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: ConfidenceItem(confidence: confidence),
          ),
        ],
      ),
    );
  }
}
