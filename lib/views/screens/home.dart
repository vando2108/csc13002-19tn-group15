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
  final _top_contributor = [
    // {
    //   "https://scontent.fvca1-1.fna.fbcdn.net/v/t1.6435-9/71286345_2193084204317518_881016848903045120_n.jpg?_nc_cat=102&ccb=1-5&_nc_sid=09cbfe&_nc_ohc=wdrPbAJTs4kAX9p6z3s&_nc_ht=scontent.fvca1-1.fna&oh=00_AT8cvEbewS_s-1WCcPYzsmZc6ziJh2eW_4bNUwljvL792w&oe=61E0F54F",
    //   "Van Do"
    // },
    {
      "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg",
      "Ha Minh"
    },
    {
      "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg",
      "Duc Tu"
    },
    {
      "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg",
      "Xuan Dang"
    },
    {
      "https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg",
      "Trung Hieu"
    }
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              ),
              CategorieCard(
                iconPath: "assets/tshirt.png",
                title: "Clothes",
              ),
              CategorieCard(
                iconPath: "assets/electronics.png",
                title: "Houseware",
              ),
              CategorieCard(
                iconPath: "assets/more.png",
                title: "More",
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          GroupText("Item"),
          const ListItem(),
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
  }) : super(key: key);

  final String iconPath;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
