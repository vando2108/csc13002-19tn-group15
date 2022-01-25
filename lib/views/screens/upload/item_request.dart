import 'package:flashare/controller/upload_controller.dart';
import 'package:flashare/views/screens/profile/other_profile.dart';
import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemRequestScreen extends StatefulWidget {
  final String itemId;
  final String itemUrl;
  final String category;
  final String itemName;
  const ItemRequestScreen(
      {Key? key,
      required this.itemId,
      required this.itemUrl,
      required this.category,
      required this.itemName})
      : super(key: key);

  @override
  _ItemRequestScreenState createState() => _ItemRequestScreenState();
}

class _ItemRequestScreenState extends State<ItemRequestScreen> {
  late Future<List> response;
  List<String> urlImage = [
    'https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg',
    'https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg',
    'https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg',
  ];
  List<String> nameUser = [
    'Cristiano Ronaldo',
    'Ronaldo',
    'CR7',
  ];

  @override
  void initState() {
    super.initState();
    response = UploadController().getListRequest(itemId: widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(4, 60, 20, 40),
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
                SizedBox(width: 8),
                AvatarCircle(imgUrl: widget.itemUrl, radius: 20),
                SizedBox(width: 16),
                Text(
                  '[${widget.category}] ${widget.itemName}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Container(
              height: 560,
              child: _renderRequest,
            ),
            SizedBox(height: 40),
            _buttonMark(),
          ],
        ),
      ),
    );
  }

  Widget _buttonMark() {
    return Container(
      child: MaterialButton(
        color: Colors.blue,
        elevation: 0,
        highlightElevation: 0,
        height: 60,
        minWidth: 200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onPressed: () async {
          List res =
              await UploadController().markItemAsSent(itemId: widget.itemId);
          if (res[0] == true) {
            _showDialog(message: "Đánh dấu thành công.");
          } else {
            _showDialog(message: res[1]);
          }
        },
        child: Text(
          'Đánh dấu đã cho',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget get _renderRequest {
    return FutureBuilder(
        future: response,
        builder: (context, snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          List data = snap.data! as List;
          if (data[0] == false) {
            return Center(
              child: Text(data[1]),
            );
          }
          data = data[1];
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                children: List<Widget>.generate(data.length, (index) {
                  // children: List<Widget>.generate(20, (indexx) {
                  //   int index = indexx % 2;
                  if (data[index]['request']['status'] == "cancelled")
                    return Container();
                  return Column(
                    children: [
                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          color: (data[index]['request']['status'] ==
                                      "archieved" ||
                                  data[index]['request']['status'] ==
                                      "accepted")
                              ? Colors.green
                              : Color.fromRGBO(239, 238, 238, 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              OtherProfileScreen(
                                                  userId: data[index]['sender']
                                                      ['id'])));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 16),
                                    AvatarCircle(
                                        imgUrl: data[index]['sender']
                                            ['avatar_link'],
                                        radius: 17),
                                    SizedBox(width: 8),
                                    Text(
                                      data[index]['sender']['name'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkResponse(
                                      onTap: () async {
                                        List res = await UploadController()
                                            .acceptRequest(
                                                requestId: data[index]
                                                    ['request']['id']);
                                        if (res[0] == true) {
                                          setState(() {
                                            response = UploadController()
                                                .getListRequest(
                                                    itemId: widget.itemId);
                                          });
                                          // TODO: link to chat userid data[index]['id'], nhớ có nút pop(context) để quay lại cái request
                                        } else {
                                          _showDialog(message: res[1]);
                                        }
                                      },
                                      child: new Container(
                                        height: 32,
                                        width: 32,
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: new Icon(
                                          Icons.check,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    InkResponse(
                                      onTap: () async {
                                        List res = await UploadController()
                                            .cancelRequest(
                                                requestId: data[index]
                                                    ['request']['id']);
                                        if (res[0] == true) {
                                          _showDialog(
                                              message: "Từ chối thành công.");
                                        } else {
                                          _showDialog(message: res[1]);
                                        }
                                      },
                                      child: new Container(
                                        height: 32,
                                        width: 32,
                                        decoration: new BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: new Icon(
                                          Icons.delete,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  );
                }),
              ),
            ),
          );
        });
  }

  _showDialog({required String message}) {
    return showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(message),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"))
            ],
          );
        });
  }
}
