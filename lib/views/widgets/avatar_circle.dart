import 'dart:math';

import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  final String imgUrl;
  final double radius;
  const AvatarCircle({ Key? key, required this.imgUrl, required this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(this.imgUrl),
        );
  }
}