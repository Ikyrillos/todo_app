import 'package:flutter/material.dart';
import 'package:todo_app_am/presentaion_Layer/screens/archived_tasks_screen.dart';
import 'package:todo_app_am/presentaion_layer/screens/add_task_screen.dart';
import 'package:todo_app_am/presentaion_layer/screens/done_tasks_screen.dart';
import 'package:todo_app_am/presentaion_layer/screens/new_tasks_screen.dart';

List<Widget> screens = [
  NewTasksScreen(),
  DoneTasksScreen(),
  ArchivedTasksScreen(),
];

List<String> titles = [
  'New Tasks',
  'Done Tasks',
  'Archived Tasks',
];

Widget? addTaskscreen() {
  return AddTasKScreen();
}
