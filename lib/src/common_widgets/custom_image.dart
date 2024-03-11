import 'package:flutter/material.dart';

/// Custom image widget that loads an image as a static asset.
class CustomImage extends StatelessWidget {
  CustomImage(
      {super.key,
      required this.imageUrl,
      this.height,
      this.width,
      this.boxFit});
  final String imageUrl;
  double? width;
  double? height;
  BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    // TODO: Use [CachedNetworkImage] if the url points to a remote resource
    return Image.asset(
      imageUrl,
      height: height,
      width: width,
      fit: boxFit,
    );
  }
}
