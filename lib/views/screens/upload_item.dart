import 'package:flashare/views/widgets/rounded_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadItemScreen extends StatefulWidget {
  const UploadItemScreen({ Key? key }) : super(key: key);

  @override
  _UploadItemScreenState createState() => _UploadItemScreenState();
}

class _UploadItemScreenState extends State<UploadItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Upload item',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 36),
            RoundedInputField(hintText: 'Name', icon: Icons.food_bank, onChanged: (value){},),
            const SizedBox(height: 36),
            RoundedInputField(hintText: 'Category', icon: Icons.category, onChanged: (value){}),
          ],
        ),
      ),
    );
  }
}