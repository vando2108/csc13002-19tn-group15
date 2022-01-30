import 'dart:convert';
import 'dart:io';

import 'package:flashare/controller/authentication_controller.dart';
import 'package:flashare/controller/profile_controller.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateAvatarScreen extends StatefulWidget {
  const UpdateAvatarScreen({Key? key}) : super(key: key);

  @override
  _UpdateAvatarScreenState createState() => _UpdateAvatarScreenState();
}

class _UpdateAvatarScreenState extends State<UpdateAvatarScreen> {
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String _base64Image = "";

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
                SizedBox(width: 60),
                Text(
                  'Change Avatar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 48),
            _uploadPhoto(),
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
                  List response = await ProfileController().updateAvatar(avatar: _base64Image);
                  if (response[0] == false) {
                    _showDialog(message: response[1]);
                  } else {
                    _showDialog(message: "Change successfully.");
                  }
                },
                child: Text(
                  'Save',
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

  Widget _uploadPhoto() {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: _image != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_image!.path),
                    height: 160,
                    width: 160,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
                  width: 160,
                  height: 160,
                  child: Icon(
                    Icons.camera_alt,
                    color: Colors.grey[800],
                  ),
                ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Image from gallery'),
                  onTap: () {
                    _imgFromGallery();
                    // Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Capture'),
                  onTap: () {
                    _imgFromCamera();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _imgFromCamera() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    List<int> imageBytes = await image!.readAsBytes();
    _base64Image = "data:image/png;base64," + base64Encode(imageBytes);
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    List<int> imageBytes = await File(image!.path).readAsBytes();
    _base64Image = "data:image/png;base64," + base64Encode(imageBytes);
    setState(() {
      _image = image;
    });
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
