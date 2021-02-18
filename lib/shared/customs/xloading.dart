import 'package:final_year_project/shared/constants/xColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitThreeBounce(
        color: kPrimaryColor,
        size: 32,
      ),
    );
  }
}
