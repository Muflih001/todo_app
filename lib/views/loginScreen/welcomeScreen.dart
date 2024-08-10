import 'package:flutter/material.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/views/loginScreen/loginScreen.dart';
import 'package:todo_app/views/registerScreen/registration_screen.dart';

class Welcomescreen extends StatelessWidget {
  const Welcomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colorconstants.DarkThemeBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: 35,
                          color: Colorconstants.DarkThemeTextColor,
                        )),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Welcome to MyTodo',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Please login to your account or create ',
                      style: TextStyle(
                          color: Colorconstants.DarkThemeTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      'new account to continue',
                      style: TextStyle(
                          color: Colorconstants.DarkThemeTextColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Loginscreen(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 45,
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                            color: Colorconstants.DarkThemeTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colorconstants.ThemeColor,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    height: 45,
                    child: Center(
                      child: Text(
                        "CREATE ACCOUNT",
                        style: TextStyle(
                            color: Colorconstants.DarkThemeTextColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 17),
                      ),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colorconstants.ThemeColor,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
