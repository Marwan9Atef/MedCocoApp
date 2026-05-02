import 'package:flutter/material.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/desktop/my_upload_desktop_list.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/mobile/my_upload_mobile_list.dart';
import 'package:medcoco/feature/my_upload/presentation/shared/my_upload_header.dart';


class MyUploadPage extends StatelessWidget {
  const MyUploadPage({super.key});

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
                const MyUploadHeader(),
                if (!isDesktop) const SizedBox(height: 16),
                Expanded(
                  child: isDesktop
                     ? const MyUploadDesktopList()
                      : const MyUploadMobileList(),
               ),
              ],
            ),
          );
        },
      ),
    );
  }
}