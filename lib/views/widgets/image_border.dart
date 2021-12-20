import 'package:flutter/material.dart';

class ImageBorder extends StatelessWidget {
  final Image image;
  const ImageBorder({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: image,
    );
  }
}
