import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/routes/route_center.dart';
import 'package:medcoco/feature/search/presentation/widgets/confidence_item.dart';

class MobileSearchImage extends StatelessWidget {
  const MobileSearchImage({super.key, required this.imagePath, required this.confidence});
  final String imagePath;
  final double confidence;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            context.push(RouteCenter.fullScreenImage, extra: imagePath);
          },
          mouseCursor: SystemMouseCursors.click,
          child: ClipRRect(
            borderRadius: BorderRadiusGeometry.all(Radius.circular(14)),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.broken_image, size: 48)),
            ),
          ),
        ),
        Positioned(top: 10, right: 10, child: ConfidenceItem(confidence: confidence)),
      ],
    );
  }
}
