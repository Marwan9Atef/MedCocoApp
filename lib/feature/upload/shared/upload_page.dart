import 'package:flutter/material.dart';
import '../presentation/widgets/info_item_column.dart';
import '../presentation/widgets/info_item_row.dart';
import '../presentation/screens/upload_screen.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 800;
        final padding = isDesktop
            ? const EdgeInsets.only(left: 63, right: 63, top: 16)
            : const EdgeInsets.only(left: 15, right: 15, top: 16);

        return Padding(
          padding: padding,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment:
                  isDesktop ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                const UploadScreen(),
                const SizedBox(height: 32),
                if (isDesktop) const InfoItemRow() else const InfoItemColumn(),
              ],
            ),
          ),
        );
      },
    );
  }
}
