import 'dart:io';

import 'package:flashare/views/widgets/app_size.dart';
import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class UploadItemScreen extends StatefulWidget {
  const UploadItemScreen({Key? key}) : super(key: key);

  @override
  _UploadItemScreenState createState() => _UploadItemScreenState();
}

class _UploadItemScreenState extends State<UploadItemScreen> {
  List<String> categories = ['Áo quần', 'Đồ gia dụng', 'Thức ăn'];
  String dropdownValue = 'Áo quần';
  File? _image;
  final ImagePicker _picker = ImagePicker();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    AppSize.config(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(CupertinoIcons.back),
                  ),
                  SizedBox(width: 60),
                  Text(
                    'Tải lên vật phẩm',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36),
              RoundedInputField(
                hintText: 'Tên vật phẩm',
                icon: Icons.food_bank,
                onChanged: (value) {},
              ),
              const SizedBox(height: 36),
              _categoryBox(),
              const SizedBox(height: 36),
              _uploadPhoto(),
              const SizedBox(height: 36),
              _descriptionBox(),
              const SizedBox(height: 36),
              _duedateBox(),
              const SizedBox(height: 36),
              _buttonUpload(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonUpload() {
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
          'Tải lên',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Widget _duedateBox() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: Color(0xffC0D7F7),
            ),
            child: MaterialButton(
              onPressed: () => _selectDate(context),
              child: Text('Hạn sử dụng'),
            ),
          ),
          SizedBox(width: 36),
          Container(
            child: Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descriptionBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff7B6363).withOpacity(0.1),
      ),
      child: TextFormField(
        maxLines: 6,
        onChanged: (value) {},
        decoration: InputDecoration(
          hintText: 'Mô tả',
          border: InputBorder.none,
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
                    _image!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8)),
                  width: 100,
                  height: 100,
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
                  title: new Text('Ảnh từ thư viện'),
                  onTap: () {
                    _imgFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Chụp ảnh'),
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
    final File image = await (_picker.pickImage(
        source: ImageSource.camera, imageQuality: 50)) as File;
    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    final File image = await (_picker.pickImage(
        source: ImageSource.gallery, imageQuality: 50)) as File;
    setState(() {
      _image = image;
    });
  }

  Widget _categoryBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff7B6363).withOpacity(0.1),
      ),
      child: Row(
        children: [
          Icon(Icons.category),
          const SizedBox(width: 20),
          DropdownButton(
            hint: Text('Loại vật phẩm'),
            value: dropdownValue,
            icon: Icon(Icons.keyboard_arrow_down),
            items: categories.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(items),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                dropdownValue = newValue.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
