import 'package:flutter/material.dart';
import 'package:todo_app/utils/colorConstants.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    this.title = '',
    this.description = '',
    this.date = '',
    this.onDelete,
    this.onEdit,
    // this.bcolor,
    this.onSwipe,
    this.endTime = '',
    this.startTime = '',
    this.priority = '',
  });
  final void Function()? onDelete;
  final void Function(String, String, Color?)? onEdit;
  final String title;
  final String description;
  final String date;
  final String endTime;
  final String startTime;
  final String priority;
  //final Color? bcolor;
  final void Function()? onSwipe;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isExpanded = false;
  bool _isEditMode = false;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  Color? _newColor;

  @override
  void initState() {
    setState(() {});
    super.initState();
    _titleController = TextEditingController(text: widget.title);
    _descriptionController = TextEditingController(text: widget.description);
    //  _newColor = widget.bcolor;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(bottom: 10.0, left: 15, right: 15, top: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _isExpanded = !_isExpanded;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
              color: Colors.grey[800]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _isEditMode
                      ? SizedBox(
                          width: 250,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: 27, fontWeight: FontWeight.w500),
                            maxLines: null,
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                          ),
                        )
                      : Text(
                          widget.title,
                          maxLines: _isExpanded ? null : 1,
                          overflow: _isExpanded ? null : TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (_isEditMode) {
                            // Save the changes
                            widget.onEdit!(_titleController.text,
                                _descriptionController.text, _newColor);
                            setState(() {
                              _isEditMode = false;
                            });
                          } else {
                            // Enter edit mode
                            setState(() {
                              _isEditMode = true;
                            });
                          }
                        },
                        icon: Icon(
                          _isEditMode ? Icons.save : Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            // Show a dialog to confirm deletion
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Delete Note'),
                                content: Text(
                                    'Are you sure you want to delete this note?'),
                                actions: [
                                  TextButton(
                                    child: Text('Cancel'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Delete'),
                                    onPressed: () {
                                      // Delete the note from the database or list
                                      widget.onDelete!(); // Update the UI
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: _isEditMode
                        ? TextFormField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                            ),
                            maxLines: null,
                          )
                        : Text(
                            widget.description,
                            maxLines: _isExpanded ? null : 4,
                            overflow:
                                _isExpanded ? null : TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                  ),
                  Spacer(),
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 1),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: widget.priority == 'High'
                                  ? Colors.red
                                  : widget.priority == 'Medium'
                                      ? Colors.yellow
                                      : Colors.green,
                              width: 2),
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        widget.priority,
                        style: TextStyle(
                            color: widget.priority == 'High'
                                ? Colors.red
                                : widget.priority == 'Medium'
                                    ? Colors.yellow
                                    : Colors.green,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  // _isEditMode
                  //     ? Colourbox(
                  //         onColourSelected: (index) {
                  //           setState(() {
                  //             _newColor = DummyDB.noteColors[index];
                  //           });
                  //         },
                  //         height: 18.0,
                  //         width: 18.0,
                  //       )
                  //     : const SizedBox(),
                  Row(
                    children: [
                      Text(
                        'Due Date : ',
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        widget.date,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),

                      // IconButton(
                      //     onPressed: () {
                      //       Share.share(
                      //           "${widget.title} \n${widget.description} \n${widget.date}");
                      //     },
                      //     icon: const Icon(Icons.share)),
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.startTime,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                      Text(
                        " - ${widget.endTime}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
