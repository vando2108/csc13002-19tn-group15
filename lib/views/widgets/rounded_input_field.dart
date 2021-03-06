// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final controller;
  final onChanged;
  final bool? isCheck;

  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    this.isCheck,
    this.controller, this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xff7B6363).withOpacity(0.1),
      ),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        onChanged: onChanged,
        controller: controller,
        obscureText: isCheck != null ? true : false,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: const Color(0xff3C3C3C),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
