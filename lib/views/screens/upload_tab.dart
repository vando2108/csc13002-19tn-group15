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
        body: Column(
          children: [
            const SizedBox(height: 30),
            _searchBar(),
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xff4285F4),
            tabs: const [
              Tab(text: 'Posted'),
              Tab(text: 'In Progress',),
              Tab(text: 'Sent',),
            ],
          ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                _postedView(),
                _inProgressView(),
                _sentView(),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedInputField(
                hintText: "Search", icon: Icons.search, onChanged: (value) {}),
          ],
        ),
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
