import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/utils/imageConstants.dart';
import 'package:todo_app/views/homeScreen/taskCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var noteBox = Hive.box('noteBox');
  List noteKeys = [];
  int? _selectedIndex;
  Uint8List? _profile;
  String? _username;
  var profileBox = Hive.box<dynamic>('profileBox');
  @override
  void initState() {
    noteKeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
    _loadProfileAndUsername();
  }

  _loadProfileAndUsername() async {
    _profile = profileBox.get('profile') as Uint8List?;
    _username = profileBox.get('username') as String?;
    setState(() {});
  }

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
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 0),
                itemCount: noteKeys.length,
                itemBuilder: (context, index) {
                  final note = noteBox.get(noteKeys[index]);
                  return TaskCard(
                    onEdit: (newTitle, newDescription, newColor) {
                      // Update the note in the database or list
                      note['title'] = newTitle;
                      note['description'] = newDescription;

                      setState(() {}); // Update the UI
                    },
                    onDelete: () {
                      // Delete the note from the database or list
                      noteBox.delete(noteKeys[index]);
                      noteKeys = noteBox.keys.toList();
                      setState(() {}); // Update the UI
                    },
                    title: note['title'],
                    description: note['description'],
                    date: note['date'],
                  );
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}
