import 'package:flutter/material.dart';
import 'package:webreinvent_todo/src/core/constants/string_constants.dart';
import 'package:webreinvent_todo/src/features/todo/views/add_task_view.dart';
import 'package:webreinvent_todo/src/features/todo/views/list_task_view.dart';

///TodoView - Display [AddTaskView] and [ListTaskView].
class TodoView extends StatelessWidget {
  const TodoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringConstants.appName,
        ),
      ),
      body: Column(
        children: [
          AddTaskView(),
          ListTaskView(),
        ],
      ),
    );
  }
}
