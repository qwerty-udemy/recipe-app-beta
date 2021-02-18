import 'package:final_year_project/initial_screen.dart';
import 'package:final_year_project/models/the_user.dart';
import 'package:final_year_project/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<TheUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return InitialScreen();
    }
  }
}
