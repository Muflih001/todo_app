import 'package:flutter/material.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/utils/imageConstants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.DarkThemeBackgroundColor,
      body: SafeArea(
        child: Container(
          color: Colorconstants.DarkThemeBackgroundColor,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colorconstants.DarkThemeTextColor,
                  ),
                  Text(
                    'Index',
                    style: TextStyle(
                        color: Colorconstants.DarkThemeTextColor, fontSize: 30),
                  ),
                  CircleAvatar()
                ],
              ),
              SizedBox(
                height: 100,
              ),
              Image.asset(Imageconstants.emptyimage),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'What do you want to do today?',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor, fontSize: 20),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Tap + to add your tasks',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
