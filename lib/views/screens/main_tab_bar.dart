import 'dart:ui';

import 'package:flashare/views/screens/chat_tab.dart';
import 'package:flashare/views/screens/home.dart';
import 'package:flashare/views/screens/profile_tab.dart';
import 'package:flashare/views/screens/upload_tab.dart';
import 'package:flashare/views/widgets/app_size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTabBar extends StatefulWidget {
  const MainTabBar({ Key? key }) : super(key: key);

  @override
  _MainTabBarState createState() => _MainTabBarState();
}

class _MainTabBarState extends State<MainTabBar> with SingleTickerProviderStateMixin{

  final _formKey = GlobalKey<FormState>();
  late TabController _tabController;
  late List<Widget> _myTabs;
  int _currentTab = 0;


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

  @override
  Widget build(BuildContext context) {
    AppSize.config(context);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Container(
        color: Color(0xffDBE3ED),
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
          onTap: (index) {
            
          },
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: _currentTab,
            children: [
              Home(),
              ChatTab(),
              UploadTab(),
              ProfileTab(),
            ],
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10,
                sigmaY: 10,
              ),
              child: Container(
                height: 76,
                color: Colors.black.withOpacity(0),
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildTabBarItem(
      int tabIndex, String title, IconData ic) {
    return Tab(
      child: Column(
        children: [
          SizedBox(height: tabIndex == _currentTab ? 2 : 4),
          Icon(
            ic,
            color: tabIndex == _currentTab ? Color.fromRGBO(61, 50, 112, 1) 
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
                fontFamily: GoogleFonts.josefinSans().fontFamily,
                fontSize: 12,
                color: tabIndex != _currentTab
                    ? Color.fromRGBO(139, 151, 168, 1)
                    : Color.fromRGBO(61, 50, 112, 1),
                shadows: <Shadow>[
                  Shadow(
                    blurRadius: 20.0,
                    color: tabIndex != _currentTab
                        ? Color.fromRGBO(139, 151, 168, 1)
                        : _currentTab == 0 || _currentTab == 3
                            ? Color.fromRGBO(2, 255, 196, 1)
                            : Color.fromRGBO(254, 44, 146, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}