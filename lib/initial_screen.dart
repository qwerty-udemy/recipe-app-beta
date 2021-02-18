import 'package:final_year_project/screens/others/add_new.dart';
import 'package:final_year_project/screens/others/chefs.dart';
import 'package:final_year_project/screens/home/home.dart';
import 'package:final_year_project/screens/others/list.dart';
import 'package:final_year_project/screens/profile/components_profile/body_profile.dart';
import 'package:final_year_project/screens/profile/profile.dart';
import 'package:final_year_project/shared/constants/xColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PageController pageController = PageController();
  int getPageIndex = 0;
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void whenPageChanges(int pageIndex) {
    setState(() {
      this.getPageIndex = pageIndex;
    });
  }

  void changePage(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.decelerate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SafeArea(
        child: Drawer(
          child: MainDrawer(),
        ),
      ),
      appBar: buildAppBar(),
      body: PageView(
        children: [
          Home(),
          TheList(),
          AddNew(),
          Chefs(),
          Profile(),
        ],
        controller: pageController,
        onPageChanged: whenPageChanges,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: getPageIndex,
        backgroundColor: Colors.white,
        activeColor: kPrimaryColor,
        inactiveColor: Color(0xFFC2C2B5),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.list)),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined)),
          BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
        ],
        onTap: changePage,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: IconButton(
        icon: Icon(
          Icons.menu_rounded,
          color: Colors.white,
        ),
        onPressed: () => _scaffoldKey.currentState.openDrawer(),
      ),
      title: Text(
        'Recipes App',
        style: TextStyle(color: Colors.white),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        SizedBox(
          width: 5,
        ),
      ],
    );
  }
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BodyProfile(),
    );
  }
}
