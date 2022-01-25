import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewScreen extends StatefulWidget {
  final List reviews;
  const ReviewScreen({Key? key, required this.reviews}) : super(key: key);

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
          children: List.generate(widget.reviews.length,
              (index) => _reviewBox(widget.reviews[index])),
        ),
      ),
    );
  }

  Widget _reviewBox(var review) {
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
                imgUrl: review['reviewer_avatar_link'] ??
                    'https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg',
                radius: 36,
              ),
              SizedBox(width: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review['reviewer_name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: List.generate(
                        5,
                        (index) => Icon(
                              Icons.star,
                              color: (index + 1 <= review['rate'])
                                  ? Colors.yellow
                                  : null,
                            )),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: 216,
                    child: Text(
                      review['review'],
                      style: TextStyle(
                        fontSize: 12,
                      ),
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
