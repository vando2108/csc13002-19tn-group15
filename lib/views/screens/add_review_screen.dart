import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
        child: SingleChildScrollView(
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
                  SizedBox(width: 88),
                  Text(
                    'Đánh giá',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AvatarCircle(
                    imgUrl:
                        'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg',
                    radius: 36,
                  ),
                  SizedBox(width: 20),
                  Text(
                    'CR7',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: Row(
                  children: List.generate(5, (index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Icon(Icons.star, color: Colors.yellow),
                    );
                  }),
                ),
              ),
              SizedBox(height: 36),
              _reviewBox(),
              SizedBox(height: 36),
              _buttonPost(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _reviewBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      // width: MediaQuery.of(context).size.width * 0.8,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff7B6363).withOpacity(0.1),
      ),
      child: TextFormField(
        maxLines: 8,
        onChanged: (value) {
          print(value);
        },
        decoration: InputDecoration(
          hintText: 'Đánh giá',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buttonPost() {
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
        onPressed: () {},
        child: Text(
          'Đăng',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
