import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImageViewer extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: kIsWeb ? null : AppBar(),
      body: PhotoView(
        onTapUp:!kIsWeb? null : (context, details, controllerValue) => context.pop(),
        imageProvider: Image.asset(imageUrl).image,
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        enableRotation: true,
        heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
      ),
    );
  }
}
