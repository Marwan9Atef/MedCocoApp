import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/mobile/my_upload_mobile_item.dart';

class MyUploadMobileList extends StatelessWidget {
  const MyUploadMobileList({super.key, required this.images});
  final List<MyImageModel> images;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: images.length,
      itemBuilder: (context, index) {
        return MyUploadMobileItem(image: images[index])
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
      separatorBuilder: (context, index) => const SizedBox(height: 17),
    );
  }
}
