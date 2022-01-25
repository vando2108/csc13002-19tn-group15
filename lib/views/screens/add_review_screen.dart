import 'package:flashare/controller/review_controller.dart';
import 'package:flashare/models/user.dart';
import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddReviewScreen extends StatefulWidget {
  final User sender;
  const AddReviewScreen({Key? key, required this.sender}) : super(key: key);

  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  var _textController = new TextEditingController(text: "");
  List<bool> star = [false, false, false, false, false];
  int _rate = 0;
  @override
  Widget build(BuildContext context) {
    User sender = widget.sender;
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
                    imgUrl: sender.avatarLink ??
                        'https://scr.vn/wp-content/uploads/2020/07/Avatar-Facebook-tr%E1%BA%AFng.jpg',
                    radius: 36,
                  ),
                  SizedBox(width: 20),
                  Text(
                    sender.Name,
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
                      onTap: () {
                        _rate = index + 1;
                        setState(() {
                          for (int i = 0; i < 5; ++i) {
                            star[i] = i <= index ? true : false;
                          }
                        });
                      },
                      child: Icon(Icons.star,
                          color: star[index] ? Colors.yellow : null),
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
        controller: _textController,
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
        onPressed: () async {
          List response = await ReviewController().addReview(
            receiver: widget.sender.ID,
            rate: _rate,
            review: _textController.text,
          );
          if (response[0] == false) {
            _showDialog(message: response[1]);
          } else {
            _showDialog(message: "Thêm đánh giá thành công.");
          }
        },
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
