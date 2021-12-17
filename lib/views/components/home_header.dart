import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        Container(
          width: size.width * 0.75,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xffEFEEEE),
            borderRadius: BorderRadius.circular(15)
          ),
          child: TextField(
            onChanged: (value) => {},
            decoration: const InputDecoration(
              enabledBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: "Search a product",
              prefixIcon: Icon(Icons.search),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15
              )
            ),
          ),
        ),
        const SizedBox(width: 10,),
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.notifications),
        )
      ],)
    );
  }
}