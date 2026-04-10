import 'package:flutter/material.dart';
import '../widgets/history_header.dart';
import '../screens/desktop/desktop_history_list.dart';
import '../screens/mobile/mobile_history_list.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth > 800;

          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: isDesktop ? 12 : 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HistoryHeader(),
                if (!isDesktop) const SizedBox(height: 16),
                Expanded(
                  child: isDesktop
                      ? const DesktopHistoryList()
                      : const MobileHistoryList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
