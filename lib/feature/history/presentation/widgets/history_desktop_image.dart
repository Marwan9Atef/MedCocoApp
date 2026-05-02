import 'package:flutter/material.dart';


class HistoryDesktopImage extends StatelessWidget {
  const HistoryDesktopImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return  ClipRRect(
            borderRadius: BorderRadiusGeometry.only(
              topLeft: Radius.circular(14),
              bottomLeft: Radius.circular(14),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
              width: 200,
              height: 200,
            ),
          );
  }
}