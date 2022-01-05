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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemRequestBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              imgUser:
                  'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
              nameUser: 'Cristiano Ronaldo',
            ),
            SizedBox(height: 12),
            ItemRequestBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              imgUser:
                  'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
              nameUser: 'Cristiano Ronaldo',
            ),
            SizedBox(height: 12),
            ItemRequestBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              imgUser:
                  'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
              nameUser: 'Cristiano Ronaldo',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _archivedView() {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemRequestBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              imgUser:
                  'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
              nameUser: 'Cristiano Ronaldo',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddReviewScreen()));
              },
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
