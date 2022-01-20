import 'package:flashare/controller/authentication_controller.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPassword = new TextEditingController();
  final _newPassword = new TextEditingController();
  final _confirmPassword = new TextEditingController();
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
              controller: _oldPassword,
            ),
            SizedBox(height: 24),
            RoundedInputField(
              hintText: 'Mật khẩu mới',
              icon: Icons.lock,
              onChanged: (value) {},
              controller: _newPassword,
            ),
            SizedBox(height: 24),
            RoundedInputField(
              hintText: 'Nhập lại mật khẩu mới',
              icon: Icons.lock,
              onChanged: (value) {},
              controller: _confirmPassword,
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
                onPressed: () async {
                  String newPassword = _newPassword.text;
                  String oldPassword = _oldPassword.text;
                  String confirmPassword = _confirmPassword.text;
                  if (newPassword != confirmPassword) {
                    _showDialog(message: "Xác nhận mật khẩu sai.");
                  } else {
                    List response =
                        await AuthenticationController().changePassword(
                      oldPassword: oldPassword,
                      newPassword: newPassword,
                    );
                    if (response[0] == false) {
                      _showDialog(message: response[1]);
                    } else {
                      _showDialog(message: "Đổi mật khẩu thành công.");
                    }
                  }
                },
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
