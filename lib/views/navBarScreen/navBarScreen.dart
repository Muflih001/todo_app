import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/views/homeScreen/homeScreen.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  var selectedIndex = 0;
  List<Widget> myScreens = [
    HomeScreen(),
    Container(
      color: Colors.red,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.black,
    ),

    // HomeScreen(),
    // SearchScreen(),
    // Comingsoonscreen(),
    // Downloadscreen(),
    // MoreScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myScreens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedItemColor: Colors.grey[700],
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            selectedIndex = value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined), label: 'Search'),
            BottomNavigationBarItem(
                icon: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: Colorconstants.ThemeColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Center(child: Icon(Icons.add)),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.file_download_sharp), label: 'Download'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile')
          ]),
    );
  }
}
