import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 60),
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
                SizedBox(width: 40),
                Text(
                  'Thay đổi mật khẩu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            RoundedInputField(
              hintText: 'Mật khẩu hiện tại',
              icon: Icons.shield,
              onChanged: (value) {},
            ),
            SizedBox(height: 24),
            RoundedInputField(
              hintText: 'Mật khẩu mới',
              icon: Icons.lock,
              onChanged: (value) {},
            ),
            SizedBox(height: 24),
            RoundedInputField(
              hintText: 'Nhập lại mật khẩu mới',
              icon: Icons.lock,
              onChanged: (value) {},
            ),
            SizedBox(height: 40),
            Container(
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
                  'Lưu thay đổi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
