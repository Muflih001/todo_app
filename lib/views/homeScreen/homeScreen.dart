import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:todo_app/utils/imageConstants.dart';
import 'package:todo_app/views/homeScreen/taskCard.dart';
import 'package:todo_app/views/loginScreen/loginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedpriorityIndex;
  String? _selectedText;
  var noteBox = Hive.box('noteBox');
  List noteKeys = [];
  int? _selectedIndex;
  Uint8List? _profile;
  String? _name;
  var profileBox = Hive.box<dynamic>('profileBox');
  @override
  void initState() {
    _selectedText = 'Ongoing';
    noteKeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
    _loadProfileAndUsername();
  }

  _loadProfileAndUsername() async {
    _profile = profileBox.get('profile') as Uint8List?;
    _name = profileBox.get('username') as String?;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colorconstants.DarkThemeBackgroundColor,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu,
              color: Colorconstants.DarkThemeTextColor,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          Text(
            "Hi, $_name" ?? "Gust",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(width: 10),
          CircleAvatar(
            radius: 25,
            backgroundImage: _profile != null
                ? MemoryImage(_profile!)
                : AssetImage(Imageconstants.avatar),
          ),
          SizedBox(width: 10),
        ],
      ),
      drawer: SafeArea(
        child: Drawer(
          backgroundColor: Colors.grey[700],
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.menu,
                      color: Colorconstants.DarkThemeTextColor,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'Delete All Notes',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor, fontSize: 18),
                ),
                onTap: () {
                  // Handle logout tap
                  //deleteAllNotes();
                },
              ),
              ListTile(
                title: Text(
                  'Help',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor, fontSize: 18),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              Spacer(),
              ListTile(
                leading: Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                      color: Colorconstants.DarkThemeTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Loginscreen(),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colorconstants.DarkThemeBackgroundColor,
      body: SafeArea(
        child: Container(
          color: Colorconstants.DarkThemeBackgroundColor,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'Manage Your\nDaily Task',
                    style: TextStyle(
                        color: Colorconstants.DarkThemeTextColor,
                        fontSize: 35,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  height: 140,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        mainAxisExtent: 55),
                    children: [
                      HomePriority(
                        text: 'Ongoing',
                        color: Colors.blue,
                        onPressed: () {
                          setState(() {
                            _selectedpriorityIndex = 0;
                            _selectedText = 'Ongoing';
                          });
                        },
                      ),
                      HomePriority(
                        text: 'High',
                        color: Colors.red,
                        onPressed: () {
                          setState(() {
                            _selectedpriorityIndex = 1;
                            _selectedText = 'High';
                          });
                        },
                      ),
                      HomePriority(
                        text: 'Medium',
                        color: Colors.yellow,
                        onPressed: () {
                          setState(() {
                            _selectedpriorityIndex = 2;
                            _selectedText = 'Medium';
                          });
                        },
                      ),
                      HomePriority(
                        text: 'Low',
                        color: Colors.green,
                        onPressed: () {
                          setState(() {
                            _selectedpriorityIndex = 3;
                            _selectedText = 'Low';
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _selectedText ?? '',
                    style: TextStyle(
                        color: Colorconstants.DarkThemeTextColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              noteKeys.isEmpty
                  ? ShowEmpty()
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 0),
                        itemCount: noteKeys.length,
                        itemBuilder: (context, index) {
                          final note = noteBox.get(noteKeys[index]);
                          if (_selectedText != 'Ongoing' &&
                              note['priority']?.toString() != _selectedText) {
                            return Container(); // Return an empty container if the note's priority doesn't match the selected priority
                          }
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
                            startTime: note['startTime'],
                            endTime: note['endTime'],
                            priority: note['priority']?.toString() ?? '',
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePriority extends StatefulWidget {
  const HomePriority({
    super.key,
    required this.text,
    required this.color,
    this.onPressed,
  });
  final String text;
  final Color color;
  final VoidCallback? onPressed;

  @override
  State<HomePriority> createState() => _HomePriorityState();
}

class _HomePriorityState extends State<HomePriority> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.color,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                color: Colorconstants.DarkThemeTextColor,
                fontSize: 25,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

class ShowEmpty extends StatelessWidget {
  const ShowEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colorconstants.DarkThemeBackgroundColor,
      child: Center(
        child: Column(
          children: [
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
    );
  }
}
