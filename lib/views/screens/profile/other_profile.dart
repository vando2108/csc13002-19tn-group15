import 'package:flashare/controller/profile_controller.dart';
import 'package:flashare/controller/review_controller.dart';
import 'package:flashare/models/user.dart';
import 'package:flashare/views/screens/profile/add_review_screen.dart';
import 'package:flashare/views/screens/profile/review_screen.dart';
import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OtherProfileScreen extends StatefulWidget {
  final String userId;
  const OtherProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _OtherProfileScreenState createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  late Future<User> data;
  late Future<List> dataReview;

  @override
  void initState() {
    super.initState();
    data = ProfileController().getProfile(userId: widget.userId);
    dataReview = ReviewController().getReview(userId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
        future: data,
        builder: (context, snap) {
          if (!snap.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          }
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        // SizedBox(width: 20),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(CupertinoIcons.back),
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Thông tin cá nhân',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24),
                    _renderProfile(
                      avatar: snap.data!.avatarLink,
                      fullName: snap.data!.Name,
                    ),
                    SizedBox(height: 24),
                    _renderInformation(
                      email: snap.data!.Email,
                      phoneNumber: snap.data!.phoneNumber,
                      address: snap.data!.address,
                    ),
                    SizedBox(height: 24),
                    _renderSetting(snap.data!),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _renderProfile({
    String? avatar,
    String? fullName,
  }) {
    return Container(
      child: Row(
        children: [
          AvatarCircle(
            imgUrl: avatar ??
                'https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg',
            radius: 60,
          ),
          SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fullName ?? 'Ronaldo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(height: 12),
              _review(),
            ],
          )
        ],
      ),
    );
  }

  Widget _review() {
    return FutureBuilder(
        future: dataReview,
        builder: (context, snap) {
          if (!snap.hasData) return Container();
          List listReview = snap.data! as List;
          if (listReview[0] == false) return Container();
          int rate = listReview[1]['rate_avg'].round();
          listReview = listReview[1]['reviews'];
          return Column(
            children: [
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    Icons.star,
                    color: (index + 1 <= rate) ? Colors.yellow : null,
                  );
                }),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReviewScreen(
                                reviews: listReview,
                              )));
                },
                child: Text(
                  '${listReview.length} đánh giá',
                  style: TextStyle(
                    color: Color.fromRGBO(66, 133, 244, 1),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          );
        });
  }

  Widget _renderInformation(
      {String? email, String? phoneNumber, String? address}) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Thông tin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.mail_outline),
              SizedBox(width: 12),
              Text(
                email ?? 'trunghieuronaldo@gmail.com',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.phone, color: Colors.black),
              SizedBox(width: 12),
              Text(
                phoneNumber ?? '6969696969',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(CupertinoIcons.location, color: Colors.black),
              SizedBox(width: 12),
              Text(
                address ?? '227 Đ.Nguyễn Văn Cừ, Phường 4, Q.5, TP.HCM',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _renderSetting(User sender) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cài đặt',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          _buttonBox(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddReviewScreen(
                            sender: sender,
                          )));
            },
            icon: Icons.person,
            action: 'Đánh giá',
            color: Colors.white,
            background: Color(0xff4285F4),
          ),
          SizedBox(height: 20),
          _buttonBox(
            onPressed: () {
              // TODO: link toi chat vs id la widget.userId
            },
            icon: Icons.person,
            action: 'Chat',
            color: Colors.white,
            background: Color(0xff4285F4),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buttonBox({
    required IconData icon,
    required String action,
    required Color color,
    required Color background,
    required var onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: background,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Row(
                children: [
                  SizedBox(width: 20),
                  Icon(icon, color: color),
                  SizedBox(width: 20),
                  Text(
                    action,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(Icons.arrow_right, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
