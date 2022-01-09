import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';

class UploadTab extends StatefulWidget {
  const UploadTab({Key? key}) : super(key: key);

  @override
  _UploadTabState createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab> with SingleTickerProviderStateMixin{
  late TabController _tabController;
  int _currentTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
    _tabController.index = _currentTab;
    _tabController.addListener(() {
      this.setState(() {
        _currentTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading:
            _searchBar(),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Color(0x4285F4),
            tabs: [
              Tab(text: 'Posted'),
              Tab(text: 'In Progress',),
              Tab(text: 'Sent',),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
          _postedView(),
          _inProgressView(),
          _sentView(),
        ]),
      ),
    );
  }

  Widget _searchBar() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInputField(
              hintText: "Search", icon: Icons.search),
        ],
      ),
    );
  }

  Widget _postedView() {
    return Container();
  }

  Widget _inProgressView() {
    return Container();
  }

  Widget _sentView() {
    return Container();
  }
}
