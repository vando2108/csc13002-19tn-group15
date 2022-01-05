import 'package:flashare/views/widgets/app_size.dart';
import 'package:flashare/views/widgets/item_posted_box.dart';
import 'package:flashare/views/widgets/item_request_box.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/material.dart';

class UploadTab extends StatefulWidget {
  const UploadTab({Key? key}) : super(key: key);

  @override
  _UploadTabState createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab>
    with SingleTickerProviderStateMixin {
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
    AppSize.config(context);
    return DefaultTabController(
      length: 3,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
            child: Column(
              children: [
                _searchBar(),
                const SizedBox(height: 12),
                TabBar(
                  controller: _tabController,
                  indicatorColor: const Color(0xff4285F4),
                  indicatorWeight: 3,
                  indicatorPadding:
                      const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
                  tabs: const [
                    Tab(text: 'Đã đăng'),
                    Tab(text: 'Đang giao'),
                    Tab(text: 'Đã gửi'),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    _postedView(),
                    _inProgressView(),
                    _sentView(),
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

  Widget _postedView() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/upload_item');
        },
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ItemPostedBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              dueDate: 3,
            ),
            SizedBox(height: 12),
            ItemPostedBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              dueDate: 3,
            ),
            SizedBox(height: 12),
            ItemPostedBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              dueDate: 3,
            ),
            SizedBox(height: 12),
            ItemPostedBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              dueDate: 3,
            ),
            SizedBox(height: 12),
            ItemPostedBox(
              imgUrl:
                  'https://cf.shopee.vn/file/5f1e81b5bd213e5ad24cf56b33195b24',
              category: 'Thời trang',
              description:
                  'Áo khoác Cardiga Chanel phù hợp với sinh viên sống tại DakLak quê Hải Phòng',
              name: 'Áo khoác',
              dueDate: 3,
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _inProgressView() {
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
              imgUser: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
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
              imgUser: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
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
              imgUser: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
              nameUser: 'Cristiano Ronaldo',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _sentView() {
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
              imgUser: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
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
              imgUser: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
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
              imgUser: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
              nameUser: 'Cristiano Ronaldo',
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
