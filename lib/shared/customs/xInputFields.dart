import 'package:final_year_project/shared/constants/xColors.dart';
import 'package:flutter/material.dart';

BoxDecoration inputContainerDecoration() {
  return BoxDecoration(
    border: Border(
      bottom: BorderSide(
        color: Colors.grey[200],
      ),
    ),
  );
}

InputDecoration inputTextFieldDecoration(String hintText, IconData icon) {
  return InputDecoration(
    hintText: hintText,
    prefixIcon: Icon(icon),
    hintStyle: TextStyle(
      color: Colors.grey,
    ),
    border: InputBorder.none,
  );
}

Widget positiveButton(String text) {
  return Container(
    height: 50,
    margin: EdgeInsets.symmetric(horizontal: 56),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: kPrimaryColor,
      //color: Colors.teal.withOpacity(0.666),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget alternateButton(String text) {
  return Container(
    height: 50,
    margin: EdgeInsets.symmetric(horizontal: 56),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(24),
      color: Colors.white,
      border: Border.all(
        color: Colors.black,
        width: 1,
      ),
    ),
    child: Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
        ),
      ),
    ),
  );
}
