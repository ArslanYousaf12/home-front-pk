import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/custom_image.dart';

class CircularImage extends StatelessWidget {
  const CircularImage(
      {super.key, required this.imageUrl, this.width, this.height});
  final String imageUrl;

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CustomImage(
        imageUrl: imageUrl,
        width: width ?? 100, // Set the width to fit your layout
        height: height ?? 100, // Set the height to fit your layout
        boxFit: BoxFit.cover, // Cover the container's shape
      ),
    );
  }
}
