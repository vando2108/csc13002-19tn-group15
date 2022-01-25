import 'dart:convert';
import 'dart:io';

import 'package:flashare/controller/authentication_controller.dart';
import 'package:flashare/controller/profile_controller.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _newPhone = new TextEditingController(text: "");
  final _newAddress = new TextEditingController(text: "");
  final _newName = new TextEditingController(text: "");

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
                  'Thay đổi thông tin',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            RoundedInputField(
              hintText: 'Tên',
              icon: Icons.person,
              onChanged: (value) {},
              controller: _newName,
            ),
            SizedBox(height: 24),
            RoundedInputField(
              hintText: 'Số điện thoại',
              icon: Icons.phone,
              onChanged: (value) {},
              controller: _newPhone,
            ),
            SizedBox(height: 24),
            RoundedInputField(
              hintText: 'Địa chỉ',
              icon: CupertinoIcons.location,
              onChanged: (value) {},
              controller: _newAddress,
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
                  String newName = _newName.text;
                  String newPhone = _newPhone.text;
                  String newAddress = _newAddress.text;
                  List response = await ProfileController().updateProfile(
                      newName: newName,
                      newPhone: newPhone,
                      newAdrr: newAddress);
                  if (response[0] == false) {
                    _showDialog(message: response[1]);
                  } else {
                    _showDialog(message: "Cập nhật thành công.");
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
