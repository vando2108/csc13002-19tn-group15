import 'package:flashare/controller/upload_controller.dart';
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
  late Future<List> dataItem;
  List itemOpen = [];
  List itemClosed = [];

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
    dataItem = UploadController().getItemUpload();
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
                    Tab(text: 'Đã gửi'),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: TabBarView(controller: _tabController, children: [
                    _postedView(),
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
            hintText: "Tìm kiếm",
            icon: Icons.search,
            onChanged: (value) {},
          ),
        ],
      ),
    );
  }

  Widget _postedView() {
    return FutureBuilder(
        future: dataItem,
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          List response = snap.data! as List;
          print(response);
          if (response[0] == false) {
            return Center(
              child: Text(response[1]),
            );
          }
          List item = response[1];
          itemOpen = [];
          item.forEach((element) {
            if (element['item']['status'] == 'open') itemOpen.add(element);
          });

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
                children: List.generate(itemOpen.length, (index) {
                  var it = itemOpen[index]['item'];
                  var requester = itemOpen[index]['requester'];
                  return Column(
                    children: [
                      requester == null
                          ? ItemPostedBox(
                              imgUrl: it['photos_link'][0],
                              category: it['category'],
                              description: it['description'],
                              name: it['title'],
                              dueDate: 3,
                              itemId: it['id'],
                            )
                          : ItemRequestBox(
                              imgUrl: it['photos_link'][0],
                              category: it['category'],
                              name: it['title'],
                              description: it['description'],
                              nameUser: requester['name'],
                              userId: requester['id'],
                              imgUser: requester['avatar_link'],
                              itemId: it['id'],
                            ),
                      SizedBox(height: 12),
                    ],
                  );
                }),
              ),
            ),
          );
        });
  }

  Widget _sentView() {
    return FutureBuilder(
        future: dataItem,
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          List response = snap.data! as List;
          if (response[0] == false) {
            return Center(
              child: Text(response[1]),
            );
          }
          List item = response[1];
          itemClosed = [];
          item.forEach((element) {
            if (element['item']['status'] == 'closed') itemClosed.add(element);
          });
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: List.generate(itemClosed.length, (index) {
                  var it = itemClosed[index]['item'];
                  var requester = itemClosed[index]['requester'];
                  return Column(
                    children: [
                      requester == null
                          ? ItemPostedBox(
                              imgUrl: it['photos_link'][0],
                              category: it['category'],
                              description: it['description'],
                              name: it['title'],
                              dueDate: 3,
                              itemId: it['id'],
                            )
                          : ItemRequestBox(
                              imgUrl: it['photos_link'][0],
                              category: it['category'],
                              name: it['title'],
                              description: it['description'],
                              nameUser: requester['name'],
                              userId: requester['id'],
                              imgUser: requester['avatar_link'],
                              itemId: it['id'],
                            ),
                      SizedBox(height: 12),
                    ],
                  );
                }),
              ),
            ),
          );
        });
  }
}
