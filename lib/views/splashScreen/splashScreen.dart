import 'package:flutter/material.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/views/getStartScreen/getStartScreen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then(
      (value) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => GetStartScreen(),
            ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.mark_chat_read,
            color: Colorconstants.ThemeColor,
            size: 100,
          ),
          Text(
            'MY TODO',
            style: TextStyle(
                color: Colorconstants.DarkThemeTextColor,
                fontSize: 40,
                fontWeight: FontWeight.w500),
          )
        ],
      )),
    );
  }
}
