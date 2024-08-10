import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/views/dummydb.dart';
import 'package:todo_app/views/homeScreen/homeScreen.dart';
import 'package:todo_app/views/registerScreen/registration_screen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: Colorconstants.DarkThemeBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: Colorconstants.DarkThemeTextColor,
                  size: 40,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login to MyTodo',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colorconstants.DarkThemeTextColor),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Username',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: Colorconstants.DarkThemeTextColor,
                style: TextStyle(color: Colorconstants.DarkThemeTextColor),
                decoration: InputDecoration(
                  hintText: 'Enter your Username',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'enter a valid email';
                  } else if (value.contains('@')) {
                    return null;
                  } else {
                    return 'invalid email adrees';
                  }
                },
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                'Password',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                obscuringCharacter: '.',
                cursorColor: Colorconstants.DarkThemeTextColor,
                style: TextStyle(color: Colorconstants.DarkThemeTextColor),
                decoration: InputDecoration(
                  hintText: 'Enter your Password',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2),
                      borderRadius: BorderRadius.circular(5)),
                ),
                validator: (value) {
                  if (value != null && value.length >= 8) {
                    return null;
                  } else {
                    return 'Password must containe atleast 8 character';
                  }
                },
              ),
              SizedBox(
                height: 80,
              ),
              InkWell(
                onTap: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;
                  if (_formKey.currentState!.validate()) {
                    if (username == usernamereg && password == passwordreg) {
                      // Credentials are correct, navigate to the next screen
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ),
                          (routes) => false);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Invalid username or password')));
                    }
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
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
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 2,
                    color: Colors.grey,
                    width: double.infinity,
                  )),
                  Text(
                    '  or  ',
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Expanded(
                      child: Container(
                    height: 2,
                    color: Colors.grey,
                    width: double.infinity,
                  ))
                ],
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Brand(Brands.google),
                        Text(
                          "Login with Google",
                          style: TextStyle(
                              color: Colorconstants.DarkThemeTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colorconstants.ThemeColor,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 50,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Brand(Brands.apple_logo),
                        Text(
                          "Login with Apple",
                          style: TextStyle(
                              color: Colorconstants.DarkThemeTextColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colorconstants.ThemeColor,
                      ),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        // Todo : write code  to navigate to registration screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen(),
                            ));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colorconstants.ThemeColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
