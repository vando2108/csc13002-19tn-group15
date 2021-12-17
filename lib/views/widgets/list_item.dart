import 'package:flutter/material.dart';

import 'item_card.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: const [
          ItemCard(
            imgPath: "https://upload.wikimedia.org/wikipedia/commons/9/9a/Reel_and_Brand_-_September_2021_-_Sarah_Stierch_05.jpg",
            title: "Beefsteak",
            dueDate: "31/12/2021",
          ),
          ItemCard(
            imgPath: "https://assets.epicurious.com/photos/57c44636082060f11022b55e/16:9/w_1280,c_limit/shutterstock_368008064.jpg", 
            title: "Fried Chicken", 
            dueDate: "15/12/2021"
          ),
          ItemCard(
            imgPath: "https://assets.epicurious.com/photos/57c44636082060f11022b55e/16:9/w_1280,c_limit/shutterstock_368008064.jpg", 
            title: "Fried Chicken", 
            dueDate: "15/12/2021"
          ),
        ],
      ),
    );
  }
}