import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 32, 20, 0),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              switch (index) {
                case 1:
                  return Column(children: [
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
                          'Các đánh giá',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 28),
                  ]);
                case 2:
                  return _renderListReviews();
                case 3:
                  return SizedBox(height: 36);
                default:
                  return SizedBox();
              }
            }),
      ),
    );
  }

  Widget _renderListReviews() {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(10, (index) => _reviewBox()),
        ),
      ),
    );
  }

  Widget _reviewBox() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(24, 16, 16, 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffEFEEEE),
          ),
          child: Row(
            children: [
              AvatarCircle(
                imgUrl:
                    'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                radius: 36,
              ),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phan Hiếu',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: List.generate(5, (index) => Icon(Icons.star, color: Colors.yellow,)),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Ngon',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    );
  }
}
