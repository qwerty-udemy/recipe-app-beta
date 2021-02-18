import 'package:final_year_project/screens/home/components_home/body_home.dart';
import 'package:final_year_project/shared/constants/xScreenSize.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        body: BodyHome(),
      ),
    );
  }
}
