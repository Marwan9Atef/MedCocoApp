import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo/core/theme/app_color.dart';

bool _isDicomXFile(XFile file) {
  final name = file.name.toLowerCase();
  return name.endsWith('.dcm') || name.endsWith('.dicom');
}

bool _webPathIsNetworkOrBlob(String path) =>
    path.startsWith('http://') ||
    path.startsWith('https://') ||
    path.startsWith('blob:');

class CompactThumbnail extends StatelessWidget {
  const CompactThumbnail({
    super.key,
    required this.image,
    required this.onRemove,
  });

  final XFile image;
  final VoidCallback onRemove;

  Widget _previewBody() {
    if (_isDicomXFile(image)) {
      return Center(
        child: Icon(
          Icons.medical_information_outlined,
          size: 40,
          color: AppColor.gray.withValues(alpha: 0.9),
        ),
      );
    }
    if (kIsWeb) {
      final path = image.path;
      if (path.isNotEmpty && _webPathIsNetworkOrBlob(path)) {
        return Image.network(path, fit: BoxFit.contain);
      }
      return FutureBuilder<Uint8List>(
        future: image.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Icon(
              Icons.broken_image_outlined,
              color: AppColor.gray.withValues(alpha: 0.9),
            );
          }
          final bytes = snapshot.data;
          if (bytes == null) {
            return Center(
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }
          return Image.memory(bytes, fit: BoxFit.contain);
        },
      );
    }
    return Image.file(File(image.path), fit: BoxFit.contain);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(color: const Color(0xFF27272A), child: _previewBody()),
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
                  child: const Icon(
                    Icons.close,
                    color: AppColor.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
