import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/colorConstants.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/views/homeScreen/homeScreen.dart';

class Createtask extends StatefulWidget {
  const Createtask({super.key});

  @override
  State<Createtask> createState() => _CreatetaskState();
}

class _CreatetaskState extends State<Createtask> {
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
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            HorizontalDatePicker(),
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
              constraints: const BoxConstraints(minHeight: 50, maxHeight: 120),
              child: TextFormField(
                cursorColor: Colors.grey,
                style: TextStyle(color: Colorconstants.DarkThemeTextColor),
                maxLines: null,
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
          ],
        ),
      )),
      bottomNavigationBar: InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            final title = _titleController.text;
            final description = _descriptionController.text;
            final date = _dateController.text;
            noteBox.add({
              "title": title,
              "description": description,
              "date": date,
            });

            noteKeys = noteBox.keys.toList();

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
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
}

class HorizontalDatePicker extends StatefulWidget {
  final String? currentdate;

  const HorizontalDatePicker({super.key, this.currentdate});
  @override
  _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  DateTime selectedDate = DateTime.now();
  int selectedMonth = DateTime.now().month;
  int selectedYear = DateTime.now().year;
  bool scheduleEnabled = true;

  @override
  Widget build(BuildContext context) {
    var selecteddate = DateFormat('yyyy-MM-dd').format(selectedDate);

    return
        //  Scaffold(
        //   backgroundColor: Colors.black,
        //   appBar: AppBar(
        //     title: Text('Create New Task'),
        //     backgroundColor: Colors.black,
        //   ),
        // body:
        Container(
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
                      activeColor: Colors.lightBlueAccent,
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
                    width: 80,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.lightBlueAccent.withOpacity(0.8)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
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
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '${date.day}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
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

              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //       horizontal: 16.0, vertical: 20.0),
              //   child: Text(
              //     '${DateFormat('MMM').format(selectedDate)}',
              //     style: TextStyle(color: Colors.white, fontSize: 18),
              //   ),
              // ),
            ],
          ),
        ],
      ),
      // ),
    );
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
