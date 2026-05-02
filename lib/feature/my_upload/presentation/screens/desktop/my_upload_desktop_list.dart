import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medcoco/core/dummy/model/ray_model.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/desktop/my_upload_desktop_item.dart';

class MyUploadDesktopList extends StatelessWidget {
  const MyUploadDesktopList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: RayModel.rayList.length,
      itemBuilder: (context, index) {
        return MyUploadDesktopItem(rayModel: RayModel.rayList[index])
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