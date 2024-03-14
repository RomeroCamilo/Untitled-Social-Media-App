import 'package:flutter/material.dart';
import 'package:social_app/fifthpage.dart';
import 'package:social_app/fourthpage.dart';
import 'package:social_app/secondpage.dart';
import 'package:social_app/thirdpage.dart';
import 'profile_page.dart';
import 'nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int currentPageIndex = 0;
  final screens = [
    const ProfilePage(),
    const SecondRoute(),
    const ThirdRoute(),
    const FourthRoute(),
    const FifthRoute(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentPageIndex],
      bottomNavigationBar: NavBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      ),
    );
  }
}
