import 'package:carousel_slider/carousel_slider.dart';
import 'package:flashare/models/item.dart';
import 'package:flashare/views/screens/item_detail.dart';
import 'package:flutter/material.dart';

import 'item_card.dart';

class ListItem extends StatefulWidget {
  const ListItem({
    Key? key,
    this.list_item,
  }) : super(key: key);
  final list_item;

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.list_item.length,
        itemBuilder: (context, index) {
          final temp = widget.list_item;
          String imgPath =
              "https://ameovat.com/wp-content/uploads/2016/05/cach-lam-ga-ran.jpg";
          if (temp[index]["photos_link"].length > 0) {
            imgPath = temp[index]["photos_link"][0];
          }
          return ItemCard(
              onClick: () {
                Item item = Item.fromJson(temp[index]);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ItemDetail(item: item);
                }));
              },
              imgPath: imgPath,
              title: temp[index]["title"].toString(),
              dueDate: temp[index]["dueDate"].toString());
        },
      ),
    );
  }
}
