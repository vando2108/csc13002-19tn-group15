import 'package:flashare/views/widgets/list_item.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Categories(),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: _index,
      //   onTap: (index) {
      //     setState(() {
      //       _index = index;
      //     });
      //   },
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.home_outlined, size: 24), label: "Home"),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.chat_bubble, size: 24), label: "Chat"),
      //     BottomNavigationBarItem(icon: Icon(Icons.book), label: "Request"),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
      //   ],
      // ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _index = 0;
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInputField(
                    hintText: "Search",
                    icon: Icons.search,
                    onChanged: (value) {}),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            TabBar(
              isScrollable: true,
              indicatorColor: const Color(0xff4285F4),
              labelColor: const Color(0xff4285F4),
              unselectedLabelColor: const Color(0xff9A9A9D),
              labelStyle: const TextStyle(fontSize: 16),
              onTap: (value) {
                _index = value;
              },
              tabs: const [
                Tab(
                  text: "Foods",
                ),
                Tab(
                  text: "Clothes",
                ),
                Tab(
                  text: "Houseware",
                ),
                Tab(
                  text: "Others",
                ),
              ],
            ),
            const ListItem(),
            const TopContributor()
          ],
        ),
      ),
    );
  }
}

class TopContributor extends StatelessWidget {
  const TopContributor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Top Contributor",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Container(
            width: double.infinity,
            height: 166,
            margin: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                image: AssetImage("assets/topcontributor.png"),
                fit: BoxFit.cover,
              )
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFF4B400).withOpacity(0.7),
                    Colors.white.withOpacity(0.7),
                  ]
                )
              ),
              child: Row(
                children: const [
                Expanded(
                  child: Text(
                    "Top 1",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                ),

              ],),
            ),
          )
        ],
      ),
    );
  }
}