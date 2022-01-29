import 'dart:io';
import 'dart:ui';

import 'package:flashare/views/screens/chat/chat_tab.dart';
import 'package:flashare/views/screens/home/home.dart';
import 'package:flashare/views/screens/profile/profile_tab.dart';
import 'package:flashare/views/screens/upload/upload_tab.dart';
import 'package:flashare/views/widgets/app_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({Key? key}) : super(key: key);

  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  late List<Widget> _myTabs;
  int _currentTab = 0;
  GlobalKey<NavigatorState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
    _tabController.index = _currentTab;
    _tabController.addListener(() {
      this.setState(() {
        _currentTab = _tabController.index;
      });
    });
    this.setState(() {
      _currentTab = _tabController.index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  late DateTime _lastQuitTime;

  @override
  Widget build(BuildContext context) {
    AppSize.config(context);
    return WillPopScope(
      onWillPop: () async {
        if (_tabController.index == 0) {
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(title: Text('Are you sure you want to quit?'), actions: <Widget>[
                    RaisedButton(
                        child: Text('Continue'),
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        }),
                    RaisedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        }),
                  ]));
          return false;
        } else {
          _tabController.animateTo(0);
          return false;
        }
      },
      child: Scaffold(
        extendBody: true,
        bottomNavigationBar: Container(
          color: Color(0xffF0F6FF),
          height: 60,
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.all(0),
            indicatorColor: Colors.transparent,
            controller: _tabController,
            tabs: [
              _buildTabBarItem(0, 'Home', Icons.home_outlined),
              _buildTabBarItem(1, 'Chat', Icons.chat_bubble),
              _buildTabBarItem(2, 'Upload', Icons.book),
              _buildTabBarItem(3, 'Profile', Icons.person),
            ],
            onTap: (index) {},
          ),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            IndexedStack(
              index: _currentTab,
              children: const [
                Home(),
                ChatTab(),
                UploadTab(),
                ProfileTab(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildTabBarItem(int tabIndex, String title, IconData ic) {
    return Tab(
      child: Column(
        children: [
          SizedBox(height: tabIndex == _currentTab ? 2 : 4),
          Icon(
            ic,
            color: tabIndex == _currentTab
                ? Color.fromRGBO(61, 50, 112, 1)
                : Color.fromRGBO(139, 151, 168, 1),
            size: tabIndex == _currentTab ? 24 : 20,
          ),
          SizedBox(height: tabIndex == _currentTab ? 2 : 4),
          Container(
            height: 12,
            child: Text(
              title,
              style: TextStyle(
                letterSpacing: 1.05,
                fontFamily: GoogleFonts.roboto().fontFamily,
                fontSize: 10,
                color: tabIndex != _currentTab
                    ? Color.fromRGBO(139, 151, 168, 1)
                    : Color.fromRGBO(61, 50, 112, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
