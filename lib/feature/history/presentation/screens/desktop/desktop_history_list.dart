import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';

import 'disktop_history_item.dart';

class DesktopHistoryList extends StatelessWidget {
  const DesktopHistoryList({super.key, required this.results});

  final List<SearchResultModel> results;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return DesktopHistoryItem(result: results[index])
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
