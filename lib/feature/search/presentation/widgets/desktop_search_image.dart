import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medcoco/core/widget/confidence_item.dart';

class DesktopSearchImage extends StatelessWidget {
  const DesktopSearchImage({
    super.key,
    required this.imagePath,
    required this.confidence,
  });
  final String imagePath;
  final double confidence;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(14),
            bottomLeft: Radius.circular(14),
          ),
          clipBehavior: Clip.antiAlias,
          child: CachedNetworkImage(
            imageUrl: imagePath,
            fit: BoxFit.fill,
            height: 200,
            width: 200,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.broken_image, size: 48)),
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: ConfidenceItem(confidence: confidence,isDesktop: true,),
        ),
      ],
    );
  }
}
