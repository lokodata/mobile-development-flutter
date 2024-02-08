// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoapp/pages/home_page.dart';

void main() async {
  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('todoBox');

  runApp(const ToDoApp());
}

class ToDoApp extends StatelessWidget {
  const ToDoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
    );
  }
}

/*

For future To Do App

When the container is clicked the dialog box will pop up that have the text state of the selected container.
The text state can then be edited with button Save or not with button Cancel same as creating new task.

~ I still don't know how to fix or avoid error of class being immutable.

*/