import 'package:flutter/material.dart';
import 'package:todo_app/views/createTask/createTask.dart';
import 'package:todo_app/views/navBarScreen/navBarScreen.dart';
import 'package:todo_app/views/splashScreen/splashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('noteBox');
  var box2 = await Hive.openBox("profileBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavBarScreen(),
    );
  }
}
