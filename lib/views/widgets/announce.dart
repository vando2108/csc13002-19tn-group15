import 'package:flutter/material.dart';

class AnnounceWidget extends StatelessWidget {
  const AnnounceWidget({
    Key? key,
    required this.imgPath,
    required this.title,
    required this.sub_title,
  }) : super(key: key);

  final String imgPath;
  final String title;
  final String sub_title;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          image: DecorationImage(image: NetworkImage(imgPath), fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(colors: [
                  const Color(0xFF4285F4).withOpacity(0.7),
                  Colors.grey.withOpacity(0.3),
                ])),
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Text.rich(TextSpan(
                  text: title + "\n",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
                  children: [
                    TextSpan(
                        text: sub_title,
                        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 12))
                  ])),
            )));
  }
}
