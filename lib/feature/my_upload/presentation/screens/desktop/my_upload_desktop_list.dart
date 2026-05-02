import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/desktop/my_upload_desktop_item.dart';

class MyUploadDesktopList extends StatelessWidget {
  final List<MyImageModel> images;
  
  const MyUploadDesktopList({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return MyUploadDesktopItem(image: images[index])
            .animate(delay: (index * 40).ms)
            .fadeIn(
              duration: 220.ms,
              curve: Curves.easeOutCubic,
            )
            .slideY(
              begin: 0.08,
              end: 0,
              duration: 220.ms,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}
