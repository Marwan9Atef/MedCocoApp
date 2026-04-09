import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo/core/utils/sizebox_util.dart';

import 'add_more_strip.dart';
import 'compact_image_grid.dart';
import 'custom_container.dart';
import 'images_header_row.dart';
import 'upload_images_button.dart';

class UploadHasImagesState extends StatelessWidget {
  const UploadHasImagesState({
    super.key,
    required this.images,
    required this.onPickImages,
  });

  final List<XFile> images;
  final VoidCallback onPickImages;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImagesHeaderRow(count: images.length),
          16.hight,
          CompactImageGrid(images: images),
          16.hight,
          AddMoreStrip(onTap: onPickImages),
          20.hight,
          UploadImagesButton(
            onTap: () {
              // TODO: wire to your upload API
            },
          ),
        ],
      ),
    );
  }
}
