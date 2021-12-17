import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({
    Key? key, required this.imgPath, required this.title, required this.dueDate,
  }) : super(key: key);

  final String imgPath;
  final String title;
  final String dueDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print("beef"),
      child: Container(
          margin: const EdgeInsets.only(left: 20, right: 0, top: 20, bottom: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 20,
                  color: const Color(0xffB0CCE1).withOpacity(0.32),
                )
              ]),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.all(25),
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(
                          imgPath),
                      fit: BoxFit.cover,
                    )),
              ),
              Text(title),
              const SizedBox(
                height: 10,
              ),
              Text(
                dueDate,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          )),
    );
  }
}