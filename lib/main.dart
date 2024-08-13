import 'package:flutter/material.dart';
import 'package:todo_app/views/createTask/createTask.dart';
import 'package:todo_app/views/loginScreen/loginScreen.dart';
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
      home: Loginscreen(),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: TimePickerExample(),
//     );
//   }
// }

// class TimePickerExample extends StatefulWidget {
//   @override
//   _TimePickerExampleState createState() => _TimePickerExampleState();
// }

// class _TimePickerExampleState extends State<TimePickerExample> {
//   TimeOfDay? selectedStartTime = TimeOfDay(hour: 18, minute: 0);
//   TimeOfDay? selectedEndTime = TimeOfDay(hour: 21, minute: 0);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('Set Time'),
//         backgroundColor: Colors.black,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Start Time Picker
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildTimePicker(
//                   label: 'Start Time',
//                   selectedTime: selectedStartTime,
//                   onTap: () => _selectTime(context, isStartTime: true),
//                 ),
//                 // End Time Picker
//                 _buildTimePicker(
//                   label: 'End Time',
//                   selectedTime: selectedEndTime,
//                   onTap: () => _selectTime(context, isStartTime: false),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTimePicker({
//     required String label,
//     required TimeOfDay? selectedTime,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             label,
//             style: TextStyle(color: Colors.white),
//           ),
//           SizedBox(height: 5),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.grey[900],
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.access_time, color: Colors.lightBlueAccent),
//                 SizedBox(width: 10),
//                 Text(
//                   selectedTime != null
//                       ? _formatTimeOfDay(selectedTime)
//                       : 'Select Time',
//                   style: TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<void> _selectTime(BuildContext context,
//       {required bool isStartTime}) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: isStartTime ? selectedStartTime! : selectedEndTime!,
//       builder: (BuildContext context, Widget? child) {
//         return Theme(
//           data: ThemeData.dark().copyWith(
//             timePickerTheme: TimePickerThemeData(
//               backgroundColor: Colors.black,
//               dialHandColor: Colors.lightBlueAccent,
//               hourMinuteTextColor: Colors.lightBlueAccent,
//             ),
//             colorScheme: ColorScheme.dark(
//               primary: Colors.lightBlueAccent,
//               onSurface: Colors.white,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(
//                 foregroundColor: Colors.lightBlueAccent,
//               ),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );

//     if (picked != null) {
//       setState(() {
//         if (isStartTime) {
//           selectedStartTime = picked;
//         } else {
//           selectedEndTime = picked;
//         }
//       });
//     }
//   }

//   String _formatTimeOfDay(TimeOfDay time) {
//     final now = DateTime.now();
//     final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
//     final format = DateFormat.jm(); // Using 'jm' format for AM/PM
//     return format.format(dt);
//   }
// }
