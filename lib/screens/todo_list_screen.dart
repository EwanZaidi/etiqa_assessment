import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/controllers/todo.controller.dart';
import 'package:todo_list/models/todo.model.dart';
import 'package:todo_list/screens/todo_list_details_screen.dart';
import 'package:todo_list/utils/counter.dart';
import 'package:todo_list/utils/style.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "To-Do List",
        ),
        elevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(const TodoDetailsScreen());
        },
        backgroundColor: const Color(0xFFF1561F),
        child: const Icon(Icons.add),
      ),
      body: Obx(
        () => controller.todoList.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.todoList.length,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  Todo todo = controller.todoList[index];
                  DateTime startDate = DateTime.parse(todo.startDate);
                  DateTime endDate = DateTime.parse(todo.endDate);
                  DateTime todayDate = DateTime.now();
                  Duration diff = endDate.difference(todayDate);
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        TodoDetailsScreen(
                          todo: todo,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 3,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    Flexible(
                                      child: Text(
                                        todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title +
                                            todo.title,
                                        maxLines: 2,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                        style: title,
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Start Date",
                                          style: secondaryTitle,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          DateFormat('dd MMM yyyy')
                                              .format(startDate),
                                          style: secondaryData,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "End Date",
                                          style: secondaryTitle,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          DateFormat('dd MMM yyyy')
                                              .format(endDate),
                                          style: secondaryData,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Time Left",
                                          style: secondaryTitle,
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          msConverter(
                                              diff.inMilliseconds.toDouble()),
                                          style: secondaryData,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              color: Color(0xFFE6E2CF),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text("Status"),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      todo.completed
                                          ? "Complete"
                                          : "Incomplete",
                                      style: secondaryData,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    const Text("Tick if completed"),
                                    Checkbox(
                                      value: todo.completed,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          todo.completed = value!;
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Center(child: Text("No To-Do yet, add one")),
      ),
    );
  }
}
