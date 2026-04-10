
import 'package:flutter/cupertino.dart';

import '../../widgets/info_item_column.dart';
import '../upload_screen.dart';

class UploadMobileScreen extends StatelessWidget {
  const UploadMobileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const UploadScreen(),
            const SizedBox(height: 32),
            const InfoItemColumn(),
          ],
        ),
      ),
    );
  }
}