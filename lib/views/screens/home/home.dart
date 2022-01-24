import 'dart:async';

import 'package:flashare/models/api.dart';
import 'package:flashare/providers/fetch_item_random.dart';
import 'package:flashare/views/components/home_header.dart';
import 'package:flashare/views/screens/home/list_item_category.dart';
import 'package:flashare/views/widgets/announce.dart';
import 'package:flashare/views/widgets/list_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Timer? timer;
  Future<ApiResponse>? list_item_;
  var _index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          list_item_ = FetchRandomItem();
        });
      }
    });
  }

  final _top_contributor = [
    {
      "https://anhdep123.com/wp-content/uploads/2021/02/anh-avatar-hai-huoc.jpg",
      "Ha Minh"
    },
    {
      "https://anhdep123.com/wp-content/uploads/2021/02/anh-avatar-hai-huoc.jpg",
      "Duc Tu"
    },
    {
      "https://anhdep123.com/wp-content/uploads/2021/02/anh-avatar-hai-huoc.jpg",
      "Xuan Dang"
    },
    {
      "https://anhdep123.com/wp-content/uploads/2021/02/anh-avatar-hai-huoc.jpg",
      "Trung Hieu"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
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
            sub_title:
                "The clothing donation event will be organize on November 21 at HCMUS ",
          ),
          GroupText("Categories"),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              CategorieCard(
                iconPath: "assets/fork.png",
                title: "Food",
                category: "food",
              ),
              CategorieCard(
                iconPath: "assets/tshirt.png",
                title: "Clothes",
                category: "clothes",
              ),
              CategorieCard(
                iconPath: "assets/electronics.png",
                title: "Houseware",
                category: "houseware",
              ),
              CategorieCard(
                iconPath: "assets/more.png",
                title: "More",
                category: "all",
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GroupText("Item"),
          FutureBuilder(
            future: list_item_,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ApiResponse temp = snapshot.data as ApiResponse;
                if (temp.Sucess == false) {
                  return const Center(child: CircularProgressIndicator());
                }
                timer!.cancel();
                return Container(
                    height: 220,
                    child: ListItem(
                      list_item: temp.Data,
                    ));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
          GroupText("Top Contributor"),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  width: size.width * 0.9,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...List.generate(_top_contributor.length, (index) {
                        return UserCard(
                            imgLink: _top_contributor[index].first,
                            name: _top_contributor[index].last);
                      })
                    ],
                  ),
                ),
                const Expanded(child: SizedBox())
              ],
            ),
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

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
    required this.imgLink,
    required this.name,
  }) : super(key: key);

  final String imgLink;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          ClipOval(
            child: Image.network(
              imgLink,
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            name,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class CategorieCard extends StatelessWidget {
  const CategorieCard({
    Key? key,
    required this.iconPath,
    required this.title,
    required this.category,
  }) : super(key: key);

  final String iconPath;
  final String title;
  final String category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ListItemByCategory(
            category: category,
          );
        }));
      },
      child: Row(
        children: [
          Container(
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
                    child: Image.asset(
                      iconPath,
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
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 9))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
