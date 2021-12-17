import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: Categories(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, size: 24), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble, size: 24), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Request"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
      ),
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
              labelStyle: const TextStyle(fontSize: 20),
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
            Container(
              width: size.width - 30,
              height: size.height - 170,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: .85,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                children: const [
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                  CardWidget(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 216,
      width: 147,
      child: InkWell(
        onTap: null,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3.0,
                  blurRadius: 5.0,
                ),
              ],
              color: Colors.white),
        ),
      ),
    );
  }
}
