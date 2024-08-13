import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/views/homeScreen/homeScreen.dart';
import 'package:todo_app/views/navBarScreen/navBarScreen.dart';

class Createtask extends StatefulWidget {
  const Createtask({super.key});

  @override
  State<Createtask> createState() => _CreatetaskState();
}

class _CreatetaskState extends State<Createtask> {
  TimeOfDay? selectedStartTime = TimeOfDay(hour: 18, minute: 0);
  TimeOfDay? selectedEndTime = TimeOfDay(hour: 21, minute: 0);

  DateTime selectedDate = DateTime.now();
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  bool scheduleEnabled = true;
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  var noteBox = Hive.box('noteBox');
  final _formKey = GlobalKey<FormState>();
  List noteKeys = [];

  @override
  void initState() {
    noteKeys = noteBox.keys.toList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var selecteddate = DateFormat('yyyy-MM-dd').format(selectedDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Task',
          style: TextStyle(color: Colorconstants.DarkThemeTextColor),
        ),
        centerTitle: true,
        backgroundColor: Colorconstants.DarkThemeBackgroundColor,
      ),
      backgroundColor: Colorconstants.DarkThemeBackgroundColor,
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              DatePickSection(selecteddate),
              TextFormField(
                cursorColor: Colors.grey,
                style: TextStyle(color: Colorconstants.DarkThemeTextColor),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                controller: _titleController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 2)),
                    // focusedBorder: OutlineInputBorder(
                    //     borderSide: BorderSide(color: Colors.black)),

                    hintText: 'Title',
                    hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                        fontSize: 18),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 10,
              ),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(minHeight: 100, maxHeight: 100),
                child: TextFormField(
                  cursorColor: Colors.grey,
                  style: TextStyle(color: Colorconstants.DarkThemeTextColor),
                  maxLines: 3,
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 2)),
                      // contentPadding: EdgeInsets.symmetric(
                      //     vertical: 30, horizontal: 10),

                      hintText: 'Description',
                      hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 18),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildTimePicker(
                      label: 'Start Time',
                      selectedTime: selectedStartTime,
                      onTap: () => _selectTime(context, isStartTime: true),
                    ),
                    // End Time Picker
                    _buildTimePicker(
                      label: 'End Time',
                      selectedTime: selectedEndTime,
                      onTap: () => _selectTime(context, isStartTime: false),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Priority',
                style: TextStyle(
                    color: Colorconstants.DarkThemeTextColor, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              PrioritySection()
            ],
          ),
        ),
      )),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            final title = _titleController.text;
            final description = _descriptionController.text;
            final date = DateFormat('MMMM dd').format(selectedDate);
            noteBox.add({
              "title": title,
              "description": description,
              "date": date,
              "startTime": selectedStartTime?.format(context) ?? '',
              "endTime": selectedEndTime?.format(context) ?? '',
              "priority": _getPriority(),
              // "startTime": selectedStartTime != null
              //     ? selectedStartTime?.format(context)
              //     : '',
              // "endTime": selectedEndTime != null
              //     ? selectedEndTime?.format(context)
              //     : '',
            });

            noteKeys = noteBox.keys.toList();

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => NavBarScreen(),
                ));
            setState(() {});
          }
        },
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colorconstants.ThemeColor,
              borderRadius: BorderRadius.circular(30)),
          child: Center(
            child: Text(
              'Add Task',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  bool _highPrioritySelected = false;
  bool _mediumPrioritySelected = false;
  bool _lowPrioritySelected = false;

  Row PrioritySection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _highPrioritySelected = true;
                _mediumPrioritySelected = false;
                _lowPrioritySelected = false;
              });
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _highPrioritySelected ? Colors.white : Colors.red,
                  width: _highPrioritySelected ? 4 : 2,
                ),
                borderRadius: BorderRadius.circular(30),
                color:
                    _highPrioritySelected ? Colors.red.withOpacity(0.2) : null,
              ),
              child: Center(
                child: Text(
                  'High',
                  style: TextStyle(
                    color: Colorconstants.DarkThemeTextColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 15),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _highPrioritySelected = false;
                _mediumPrioritySelected = true;
                _lowPrioritySelected = false;
              });
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _mediumPrioritySelected ? Colors.white : Colors.amber,
                  width: _mediumPrioritySelected ? 4 : 2,
                ),
                borderRadius: BorderRadius.circular(30),
                color: _mediumPrioritySelected
                    ? Colors.amber.withOpacity(0.2)
                    : null,
              ),
              child: Center(
                child: Text(
                  'Medium',
                  style: TextStyle(
                    color: Colorconstants.DarkThemeTextColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _highPrioritySelected = false;
                _mediumPrioritySelected = false;
                _lowPrioritySelected = true;
              });
            },
            child: Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: _lowPrioritySelected ? Colors.white : Colors.green,
                  width: _lowPrioritySelected ? 4 : 2,
                ),
                borderRadius: BorderRadius.circular(30),
                color:
                    _lowPrioritySelected ? Colors.green.withOpacity(0.2) : null,
              ),
              child: Center(
                child: Text(
                  'Low',
                  style: TextStyle(
                    color: Colorconstants.DarkThemeTextColor,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  String _getPriority() {
    if (_highPrioritySelected) {
      return 'High';
    } else if (_mediumPrioritySelected) {
      return 'Medium';
    } else {
      return 'Low';
    }
  }

  Container DatePickSection(String selecteddate) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Month and Year Selector
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButton<int>(
                        dropdownColor: Colors.black,
                        value: selectedMonth,
                        items: List.generate(12, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text(
                              DateFormat('MMMM').format(DateTime(0, index + 1)),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedMonth = value!;
                            _updateSelectedDate();
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: 30,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: DropdownButton<int>(
                        dropdownColor: Colors.black,
                        value: selectedYear,
                        items: List.generate(100, (index) {
                          return DropdownMenuItem(
                            value: selectedYear - 50 + index,
                            child: Text(
                              '${selectedYear - 50 + index}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          );
                        }),
                        onChanged: (value) {
                          setState(() {
                            selectedYear = value!;
                            _updateSelectedDate();
                          });
                        },
                      ),
                    ),
                  ],
                ),
                // Schedule Toggle
                Row(
                  children: [
                    Text(
                      'Schedule',
                      style: TextStyle(color: Colors.white),
                    ),
                    Switch(
                      value: scheduleEnabled,
                      onChanged: (value) {
                        setState(() {
                          scheduleEnabled = value;
                        });
                      },
                      activeColor: Colors.cyan[100],
                    ),
                  ],
                ),
              ],
            ),
          ),
          //  SizedBox(height: 10),
          Container(
            height: 100, // Set the height for the horizontal date picker
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _daysInMonth(selectedYear, selectedMonth),
              itemBuilder: (context, index) {
                DateTime date =
                    DateTime(selectedYear, selectedMonth, index + 1);
                bool isSelected = _isSameDay(selectedDate, date);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = date;
                    });
                  },
                  child: Container(
                    width: 70,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.cyan[100] : Colors.transparent,
                      borderRadius: BorderRadius.circular(40),
                      border: isSelected
                          ? null
                          : Border.all(color: Colors.white.withOpacity(0.2)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('EEE').format(date).substring(0, 3),
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                            color: isSelected
                                ? Colors.black
                                : Colors.white.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            color: isSelected ? Colors.black : Colors.white,
                            fontSize: 19,
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0, vertical: 20.0),
                child: Text(
                  'Selected Date: $selecteddate',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
      // ),
    );
  }

  Widget _buildTimePicker({
    required String label,
    required TimeOfDay? selectedTime,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Icon(Icons.access_time, color: Colors.lightBlueAccent),
                SizedBox(width: 10),
                Text(
                  selectedTime != null
                      ? _formatTimeOfDay(selectedTime)
                      : 'Select Time',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTime(BuildContext context,
      {required bool isStartTime}) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? selectedStartTime! : selectedEndTime!,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.black,
              dialHandColor: Colors.lightBlueAccent,
              hourMinuteTextColor: Colors.white,
            ),
            colorScheme: ColorScheme.dark(
              primary: Colors.lightBlueAccent,
              onSurface: Colors.white,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.lightBlueAccent,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final format = DateFormat.jm(); // Using 'jm' format for AM/PM
    return format.format(dt);
  }

  void _updateSelectedDate() {
    setState(() {
      selectedDate = DateTime(selectedYear, selectedMonth, selectedDate.day);
    });
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  int _daysInMonth(int year, int month) {
    final firstDayOfNextMonth =
        (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
    return firstDayOfNextMonth.subtract(Duration(days: 1)).day;
  }
}

// class HorizontalDatePicker extends StatefulWidget {
//   final String? currentdate;

//   const HorizontalDatePicker({super.key, this.currentdate});
//   @override
//   _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
// }

// class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
//   DateTime selectedDate = DateTime.now();
//   int selectedMonth = DateTime.now().month;
//   int selectedYear = DateTime.now().year;
//   bool scheduleEnabled = true;

//   @override
//   Widget build(BuildContext context) {
//     var selecteddate = DateFormat('yyyy-MM-dd').format(selectedDate);

//     return
//         //  Scaffold(
//         //   backgroundColor: Colors.black,
//         //   appBar: AppBar(
//         //     title: Text('Create New Task'),
//         //     backgroundColor: Colors.black,
//         //   ),
//         // body:
//         Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Month and Year Selector
//                 Row(
//                   children: [
//                     Container(
//                       padding: EdgeInsets.only(left: 10),
//                       height: 30,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey, width: 2),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: DropdownButton<int>(
//                         dropdownColor: Colors.black,
//                         value: selectedMonth,
//                         items: List.generate(12, (index) {
//                           return DropdownMenuItem(
//                             value: index + 1,
//                             child: Text(
//                               DateFormat('MMMM').format(DateTime(0, index + 1)),
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 18),
//                             ),
//                           );
//                         }),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedMonth = value!;
//                             _updateSelectedDate();
//                           });
//                         },
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(
//                         left: 10,
//                       ),
//                       height: 30,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.grey, width: 2),
//                           borderRadius: BorderRadius.circular(20)),
//                       child: DropdownButton<int>(
//                         dropdownColor: Colors.black,
//                         value: selectedYear,
//                         items: List.generate(100, (index) {
//                           return DropdownMenuItem(
//                             value: selectedYear - 50 + index,
//                             child: Text(
//                               '${selectedYear - 50 + index}',
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 18),
//                             ),
//                           );
//                         }),
//                         onChanged: (value) {
//                           setState(() {
//                             selectedYear = value!;
//                             _updateSelectedDate();
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Schedule Toggle
//                 Row(
//                   children: [
//                     Text(
//                       'Schedule',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     Switch(
//                       value: scheduleEnabled,
//                       onChanged: (value) {
//                         setState(() {
//                           scheduleEnabled = value;
//                         });
//                       },
//                       activeColor: Colors.lightBlueAccent,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//           //  SizedBox(height: 10),
//           Container(
//             height: 100, // Set the height for the horizontal date picker
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: _daysInMonth(selectedYear, selectedMonth),
//               itemBuilder: (context, index) {
//                 DateTime date =
//                     DateTime(selectedYear, selectedMonth, index + 1);
//                 bool isSelected = _isSameDay(selectedDate, date);

//                 return GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       selectedDate = date;
//                     });
//                   },
//                   child: Container(
//                     width: 80,
//                     margin: EdgeInsets.symmetric(horizontal: 4.0),
//                     decoration: BoxDecoration(
//                       color: isSelected
//                           ? Colors.lightBlueAccent.withOpacity(0.8)
//                           : Colors.transparent,
//                       borderRadius: BorderRadius.circular(10),
//                       border: isSelected
//                           ? null
//                           : Border.all(color: Colors.white.withOpacity(0.2)),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           DateFormat('EEE').format(date).substring(0, 3),
//                           style: TextStyle(
//                             fontSize: 19,
//                             color: Colors.white.withOpacity(0.7),
//                           ),
//                         ),
//                         SizedBox(height: 5),
//                         Text(
//                           '${date.day}',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 19,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 16.0, vertical: 20.0),
//                 child: Text(
//                   'Selected Date: $selecteddate',
//                   style: TextStyle(color: Colors.white, fontSize: 18),
//                 ),
//               ),

//               // Padding(
//               //   padding: const EdgeInsets.symmetric(
//               //       horizontal: 16.0, vertical: 20.0),
//               //   child: Text(
//               //     '${DateFormat('MMM').format(selectedDate)}',
//               //     style: TextStyle(color: Colors.white, fontSize: 18),
//               //   ),
//               // ),
//             ],
//           ),
//         ],
//       ),
//       // ),
//     );
//   }

//   void _updateSelectedDate() {
//     setState(() {
//       selectedDate = DateTime(selectedYear, selectedMonth, selectedDate.day);
//     });
//   }

//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }

//   int _daysInMonth(int year, int month) {
//     final firstDayOfNextMonth =
//         (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
//     return firstDayOfNextMonth.subtract(Duration(days: 1)).day;
//   }
// }
