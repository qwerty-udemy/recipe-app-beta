import 'package:final_year_project/shared/constants/xColors.dart';
import 'package:flutter/material.dart';

BoxDecoration backgroundContainerDecoration() {
  return BoxDecoration(
    color: Colors.white.withOpacity(0.87),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(60),
      topRight: Radius.circular(60),
    ),
  );
}

BoxDecoration backgroundInputDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: kPrimaryColor.withOpacity(0.5),
        blurRadius: 16,
        offset: Offset(0, 8),
      ),
    ],
  );
}
