import 'package:final_year_project/screens/profile/components_profile/info_profile.dart';
import 'package:final_year_project/screens/profile/components_profile/menu_item_profile.dart';
import 'package:final_year_project/services/auth.dart';
import 'package:final_year_project/shared/constants/xColors.dart';
import 'package:final_year_project/shared/constants/xScreenSize.dart';
import 'package:flutter/material.dart';

class BodyProfile extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Column(
            children: [
              InfoProfile(
                image: 'assets/images/pic.png',
                name: 'User Full Name',
                email: 'email.id2021@gmail.com',
              ),
              SizedBox(
                height: SizeConfig.defaultSize * 2,
              ),
              ProfileMenuItem(
                icon: Icons.bookmark_rounded,
                title: 'Saved Recipes',
                press: () {},
              ),
              ProfileMenuItem(
                icon: Icons.monetization_on_rounded,
                title: 'Premium Plan',
                press: () {},
              ),
              ProfileMenuItem(
                icon: Icons.language_rounded,
                title: 'Change Language',
                press: () {},
              ),
              ProfileMenuItem(
                icon: Icons.info_outline_rounded,
                title: 'Help',
                press: () {},
              ),
            ],
          ),
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: kPrimaryColor,
                ),
                label: Text(
                  'Settings',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.logout,
                  color: kPrimaryColor,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
