import 'package:flashare/views/widgets/avatar_circle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({ Key? key }) : super(key: key);

  @override
  _ProfileTabState createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  'Thông tin của tôi',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 24),
              _renderProfile(),
              SizedBox(height: 24),
              _renderInformation(),
              SizedBox(height: 24),
              _renderSetting(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderProfile() {
    return Container(
      child: Row(
        children: [
          AvatarCircle(
            imgUrl: 'https://upload.wikimedia.org/wikipedia/commons/8/8c/Cristiano_Ronaldo_2018.jpg', 
            radius: 60,
          ),
          SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ronaldo',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              SizedBox(height: 12),
              Text('Quản trị viên',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 12),
              Row(
                children: List.generate(5, (index) {
                  return Icon(Icons.star, color: Colors.yellow,);
                }),
              ),
              SizedBox(height: 12),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/review');
                },
                child: Text(
                  '4 đánh giá',
                  style: TextStyle(
                    color: Color.fromRGBO(66, 133, 244, 1),
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _renderInformation() {
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
                'trunghieuronaldo@gmail.com',
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
                '6969696969',
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
                '227 Đ.Nguyễn Văn Cừ, Phường 4, Q.5, TP.HCM',
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

  Widget _renderSetting() {
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
            onPressed: (){},
            icon: Icons.person,
            action: 'Thay đổi thông tin cá nhân',
            color: Colors.white,
            background: Color(0xff4285F4),
          ),
          SizedBox(height: 20),
          _buttonBox(
            onPressed: (){
              Navigator.pushNamed(context, '/change_password');
            },
            icon: Icons.security,
            action: 'Thay đổi mật khẩu',
            color: Colors.white,
            background: Color(0xff4285F4),
          ),
          SizedBox(height: 20),
          _buttonBox(
            onPressed: (){
              Navigator.pushNamed(context, '/my_request');
            },
            icon: Icons.storage,
            action: 'Yêu cầu của tôi',
            color: Colors.white,
            background: Color(0xff4285F4),
          ),
          SizedBox(height: 20),
          _buttonBox(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icons.exit_to_app,
            action: 'Đăng xuất',
            color: Color(0xff395185),
            background: Color.fromRGBO(218, 218, 218, 0.5),
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