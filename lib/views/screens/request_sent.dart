import 'package:flashare/controller/request_controller.dart';
import 'package:flashare/views/screens/add_review_screen.dart';
import 'package:flashare/views/widgets/app_size.dart';
import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flashare/views/widgets/item_posted_box.dart';
import 'package:flashare/views/widgets/item_request_box.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RequestSentScreen extends StatefulWidget {
  const RequestSentScreen({Key? key}) : super(key: key);

  @override
  _RequestSentScreenState createState() => _RequestSentScreenState();
}

class _RequestSentScreenState extends State<RequestSentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTab = 0;
  late Future<List> dataPending;
  late Future<List> dataArchived;
  var requestController = RequestController();

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController.index = _currentTab;
    _tabController.addListener(() {
      this.setState(() {
        _currentTab = _tabController.index;
      });
    });
    dataPending = requestController.getRequestPending();
    dataArchived = requestController.getRequestArchived();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppSize.config(context);
    return DefaultTabController(
      length: 2,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(CupertinoIcons.back),
                    ),
                    SizedBox(width: 60),
                    Text(
                      'Yêu cầu của tôi',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                _searchBar(),
                const SizedBox(height: 12),
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xff4285F4),
                  indicatorWeight: 2,
                  indicatorPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  tabs: const [
                    Tab(text: 'Đang giao'),
                    Tab(text: 'Đã nhận'),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    _pendingView(),
                    _archivedView(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedInputField(
              hintText: "Tìm kiếm", icon: Icons.search, onChanged: (value) {}),
        ],
      ),
    );
  }

  Widget _pendingView() {
    return FutureBuilder(
      future: dataPending,
      builder: (context, snap) {
        if (!snap.hasData)
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        List data = snap.data as List;
        if (data[0] == false) {
          return Center(child: Text(data[1]));
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(data[1].length, (index) {
                var item = data[1][index]['item'];
                var user = data[1][index]['sender'];
                return Column(
                  children: [
                    ItemRequestBox(
                      imgUrl:
                          item['photos_link'][0] ?? 'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
                      category: item['category'] ?? 'Thời trang',
                      description:
                          item['description'] ?? 'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
                      name: item['title'] ??'Áo khoác',
                      imgUser:
                          user['avatar_link'] ?? 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                      nameUser: user['name'] ?? 'Cristiano Ronaldo',
                      userId: user['id'] ?? '',
                      itemId: item['id'],
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _archivedView() {
    return FutureBuilder(
      future: dataArchived,
      builder: (context, snap) {
        if (!snap.hasData)
          return Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        List data = snap.data as List;
        if (data[0] == false) {
          return Center(child: Text(data[1]));
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: List.generate(data[1].length, (index) {
                var item = data[1][index]['item'];
                var user = data[1][index]['sender'];
                return Column(
                  children: [
                    ItemRequestBox(
                      imgUrl: item['photos_link'][0] ??
                          'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
                      category: item['category'] ?? 'Thời trang',
                      description: item['description'] ??
                          'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
                      name: item['title'] ?? 'Áo khoác',
                      imgUser: user['avatar_link'] ??
                          'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                      nameUser: user['name'] ?? 'Cristiano Ronaldo',
                      userId: user['id'] ?? '',
                      itemId: item['id'],
                    ),
                    SizedBox(height: 10),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
