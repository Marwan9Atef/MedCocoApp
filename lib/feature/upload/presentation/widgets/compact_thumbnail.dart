import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo/core/theme/app_color.dart';

class CompactThumbnail extends StatelessWidget {
  const CompactThumbnail({
    super.key,
    required this.image,
    required this.onRemove,
  });

  final XFile image;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: const Color(0xFF27272A),
            child: kIsWeb
                ? Image.network(image.path, fit: BoxFit.contain)
                : Image.file(File(image.path), fit: BoxFit.contain),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: AppColor.anotherBlack.withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close, color: AppColor.white, size: 16),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
