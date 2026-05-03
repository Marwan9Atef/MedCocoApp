import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';

import 'mobile_history_item.dart';

class MobileHistoryList extends StatelessWidget {
  const MobileHistoryList({super.key, required this.results});

  final List<SearchResultModel> results;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return MobileHistoryItem(result: results[index])
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
