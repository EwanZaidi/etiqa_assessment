import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/screens/todo_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'To do list',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.yellow,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(background: const Color(0xFFEFEFEF)),
      ),
      initialRoute: '/home',
      getPages: [
        //Simple GetPage
        GetPage(name: '/home', page: () => TodoListScreen()),
      ],
    );
  }
}
