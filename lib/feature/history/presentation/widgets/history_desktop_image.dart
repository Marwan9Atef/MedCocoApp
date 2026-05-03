import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:medcoco/core/widget/simple_loading_indicator.dart';

class HistoryDesktopImage extends StatelessWidget {
  const HistoryDesktopImage({
    super.key,
    required this.imagePath,
    
  });

  final String imagePath;


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
            width: 200,
            height: 200,
            placeholder: (context, url) =>
                const Center(child: SimpleLoadingIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.broken_image, size: 48)),
          ),
        ),
      
      ],
    );
  }
}
