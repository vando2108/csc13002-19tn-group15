import 'package:flashare/views/components/home_header.dart';
import 'package:flashare/views/widgets/announce.dart';
import 'package:flashare/views/widgets/list_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          HomeHeader(size: size),
          const SizedBox(
            height: 20,
          ),
          GroupText("Event"),
          const AnnounceWidget(
            imgPath: "https://www.hcmus.edu.vn/images/2020/04/07/bn2.jpg", 
            title: "HCMUS Donation Event",
            sub_title: "The clothing donation event will be organize on November 21 at HCMUS ",
          ),
          GroupText("Categories"),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CategorieCard(iconPath: "assets/fork.png", title: "Food",),
              CategorieCard(iconPath: "assets/tshirt.png", title: "Clothes",),
              CategorieCard(iconPath: "assets/electronics.png", title: "Houseware",),
              CategorieCard(iconPath: "assets/more.png", title: "More",),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GroupText("Item"),
          const ListItem(),
          GroupText("Announce"),
          const AnnounceWidget(
            imgPath: "https://lightcharity.com/wp-content/uploads/2020/01/A-GREAT-1000.jpg",
            title: "Top Contributor",
            sub_title: "Help others and be happy",
          )
        ],
      ),
      
    );
  }

  // ignore: non_constant_identifier_names
  Row GroupText(String text) {
    return Row(
      children: [
        const SizedBox(
          width: 25,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
      ],
    );
  }
}

class CategorieCard extends StatelessWidget {
  const CategorieCard({
    Key? key, required this.iconPath, required this.title,
  }) : super(key: key);

  final String iconPath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: 55,
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: const Color(0xfff4b400).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10)),
              child: 
                Image.asset(iconPath,
                  color: const Color(
                    0xffBA8900,
                  ),
                  scale: 0.9,
                ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10)
          )
        ],
      ),
    );
  }
}
