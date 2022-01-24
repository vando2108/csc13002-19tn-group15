import 'dart:async';

import 'package:flashare/models/api.dart';
import 'package:flashare/models/item.dart';
import 'package:flashare/models/user.dart';
import 'package:flashare/utils/user_storage.dart';
import 'package:flashare/views/screens/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemDetail extends StatelessWidget {
  ItemDetail({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        shadowColor: Colors.transparent,
      ),
      body: TempBody(item: item),
    );
  }
}

class TempBody extends StatefulWidget {
  TempBody({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  @override
  State<TempBody> createState() => _TempBodyState();
}

class _TempBodyState extends State<TempBody> {
  int currentIndex = 0;
  Future<ApiResponse>? user_info;
  Future<ApiResponse>? request;
  Timer? timer;
  String? user_id;

  // ignore: non_constant_identifier_names
  Future<void> Request() async {
    setState(() {
      request = RequestItem(user_id.toString(), widget.item.id);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        if (!mounted) return;
        user_info = FetchUser(widget.item.upload_by.toString());
        user_id = SecureStorage.readSecureData(SecureStorage.userID).toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> ListImg = [
      "https://upload.wikimedia.org/wikipedia/commons/9/9a/Reel_and_Brand_-_September_2021_-_Sarah_Stierch_05.jpg",
      "https://thucthan.com/media/2018/07/beefsteak/cach-lam-beefsteak.jpg",
      "https://cf.shopee.vn/file/5f32380ce6908b9c81a1404146e88a36",
    ];
    if (widget.item.photos_link.isNotEmpty) {
      ListImg = widget.item.photos_link;
    }
    DateTime date = DateTime.parse(widget.item.due_date.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: 240,
                  width: double.infinity,
                  child: PageView.builder(
                      onPageChanged: (value) {
                        setState(() {
                          currentIndex = value;
                        });
                      },
                      itemCount: ListImg.length,
                      itemBuilder: (context, index) {
                        return ShowImage(img_link: ListImg[index]);
                      }),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      ListImg.length, (index) => buildDot(index: index)))
            ],
          ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Text(
                  widget.item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 28,
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  date.day.toString() +
                      "-" +
                      date.month.toString() +
                      "-" +
                      date.year.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffDB4437),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 55.0),
                child: Text(
                  "Upload by",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              FutureBuilder<ApiResponse>(
                future: user_info,
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(child: const CircularProgressIndicator());
                  ApiResponse temp = snapshot.data as ApiResponse;
                  if (temp.Sucess == false) {
                    return Center(child: const CircularProgressIndicator());
                  }
                  timer!.cancel();
                  User user = User.fromJson(temp.Data);
                  return UserAvatarName(user);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 55.0),
                child: Text(
                  "Desciption",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.black),
                ),
              ),
              SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.only(left: 55, right: 23),
                  child: Text(
                    widget.item.desc.toString(),
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      Request();
                      FutureBuilder(
                        future: request,
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Scaffold(
                              body: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.transparent,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            );
                          }
                          ApiResponse temp = snapshot.data as ApiResponse;
                          if (temp.Sucess == false) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: const Text("Error"),
                                  content: Text(temp.Data),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("Close"))
                                  ],
                                );
                              },
                            );
                          }
                          return CircularProgressIndicator();
                        },
                      );
                    },
                    child: const SizedBox(
                        height: 60,
                        width: 240,
                        child: Center(
                            child: Text(
                          "Request",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )))),
              ),
            ],
          ),
        )
      ],
    );
  }

  Row UserAvatarName(User user) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(left: 55, top: 15),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              // ignore: prefer_const_literals_to_create_immutables
              boxShadow: [
                const BoxShadow(
                  offset: Offset(0, 3),
                  blurRadius: 10,
                  color: Colors.grey,
                )
              ],
              image: DecorationImage(
                  image: NetworkImage(
                    (user.avatarLink == "")
                        ? "https://www.winhelponline.com/blog/wp-content/uploads/2017/12/user.png"
                        : user.avatarLink.toString(),
                  ),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            user.Name,
            style: const TextStyle(
              fontSize: 14,
              letterSpacing: 1,
            ),
          ),
        )
      ],
    );
  }

  Container buildDot({required int index}) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      height: 6,
      width: currentIndex == index ? 20 : 6,
      decoration: BoxDecoration(
          color: currentIndex == index ? const Color(0xff4285F4) : Colors.grey,
          borderRadius: BorderRadius.circular(3)),
    );
  }
}

class ShowImage extends StatelessWidget {
  const ShowImage({
    Key? key,
    required this.img_link,
  }) : super(key: key);

  final String img_link;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      height: 240,
      width: 240,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 3),
              spreadRadius: 5,
              blurRadius: 10,
              color: Colors.grey,
            )
          ],
          image: DecorationImage(
              image: NetworkImage(
                img_link,
              ),
              fit: BoxFit.cover)),
    );
  }
}
