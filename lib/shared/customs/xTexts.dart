import 'package:flutter/material.dart';

Widget textBig(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 42,
    ),
  );
}

Widget textSmall(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.white,
      fontSize: 24,
    ),
  );
}

Widget textError(String error) {
  return Text(
    error,
    style: TextStyle(
      color: Colors.red,
      fontSize: 16,
    ),
  );
}
