import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../../core/dummy/model/ray_model.dart';
import 'disktop_history_item.dart';

class DesktopHistoryList extends StatelessWidget {
  const DesktopHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: RayModel.rayList.length,
      itemBuilder: (context, index) {
        return DesktopHistoryItem(rayModel: RayModel.rayList[index])
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
