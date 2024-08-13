import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/utils/imageConstants.dart';
import 'package:todo_app/views/homeScreen/homeScreen.dart';
import 'package:todo_app/views/navBarScreen/navBarScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<ProfileScreen> {
  File? _selectedImage;
  var profileBox = Hive.box('profileBox');
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Create Your Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CircleAvatar(
                    radius: 70,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : AssetImage(
                            Imageconstants.avatar), // default avatar image
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          _selectedImage = File(pickedFile.path);
                          _storeImageInNoteBox(_selectedImage!);
                        });
                      }
                    },
                    child: Text('Edit Profile'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: Colors.grey,
                    controller: _textController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2),
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NavBarScreen(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: Text(
                            "Skip",
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                      TextButton(
                        onPressed: () {
                          if (_selectedImage != null) {
                            _storeImageInNoteBox(_selectedImage!);
                          }
                          _storeTextInNoteBox(_textController.text);
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavBarScreen()),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Text(
                          "Next",
                          style:
                              TextStyle(color: Colors.amber[100], fontSize: 16),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _storeImageInNoteBox(File image) async {
    Uint8List imageBytes = await image.readAsBytes();
    profileBox.put('profile', imageBytes);
  }

  void _storeTextInNoteBox(String text) {
    profileBox.put('username', text);
  }
}

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(),
          Text(
            'data',
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }
}
