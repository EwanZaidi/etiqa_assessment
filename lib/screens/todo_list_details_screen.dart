import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/controllers/todo.controller.dart';
import 'package:todo_list/models/todo.model.dart';

class TodoDetailsScreen extends StatefulWidget {
  final Todo? todo;
  const TodoDetailsScreen({super.key, this.todo});

  @override
  State<TodoDetailsScreen> createState() => _TodoDetailsScreenState();
}

class _TodoDetailsScreenState extends State<TodoDetailsScreen> {
  final TextEditingController _titleC = TextEditingController();
  final TextEditingController _startDateC = TextEditingController();
  final TextEditingController _endDateC = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  final _formKey = GlobalKey<FormState>();

  final contoller = Get.find<TodoController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) setData();
  }

  setData() {
    Todo todo = widget.todo!;
    _titleC.text = todo.title;
    _startDate = DateTime.parse(todo.startDate);
    _endDate = DateTime.parse(todo.endDate);

    _startDateC.text = DateFormat('dd-MM-yyyy').format(_startDate!);
    _endDateC.text = DateFormat('dd-MM-yyyy').format(_endDate!);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.todo == null ? "Add new To-Do List" : "Edit To-Do List"),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.yellow, // Background Color
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: _submit,
          child: const Text('Create Now'),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _titleC,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
              minLines: 4,
              maxLines: 4,
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _startDateC,
              decoration: const InputDecoration(
                labelText: "Start Date",
                border: OutlineInputBorder(),
              ),
              readOnly: true, // when true user cannot edit text
              onTap: () async {
                _showDatePicker("Start");
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _endDateC,
              decoration: const InputDecoration(
                labelText: "Estimated End Date",
                border: OutlineInputBorder(),
              ),
              readOnly: true, // when true user cannot edit text
              onTap: () async {
                _showDatePicker("End");
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return "This field is required";
                }
                return null;
              },
            )
          ],
        ),
      ),
    );
  }

  _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Todo todo = Todo(
        title: _titleC.text,
        startDate: _startDate!.toLocal().toIso8601String(),
        endDate: _endDate!.toLocal().toIso8601String(),
        completed: false);

    contoller.addItemInList(todo);

    Navigator.pop(context);
  }

  _showDatePicker(String whatDate) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), //get today's date
        firstDate: DateTime
            .now(), //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (whatDate != 'Start' &&
        _startDate != null &&
        pickedDate != null &&
        pickedDate.isBefore(_startDate!)) {
      const snackBar = SnackBar(
        content: Text('End date must be after than start date'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    } else if (whatDate == 'Start' &&
        _endDate != null &&
        pickedDate != null &&
        pickedDate.isAfter(_endDate!)) {
      const snackBar = SnackBar(
        content: Text('Start date must be before than end date'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return;
    }

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);

      setState(() {
        if (whatDate == 'Start') {
          _startDate = pickedDate;
          _startDateC.text = formattedDate;
        } else {
          _endDate = pickedDate;
          _endDateC.text = formattedDate;
        }
      });
    } else {
      print("Date is not selected");
    }
  }
}
