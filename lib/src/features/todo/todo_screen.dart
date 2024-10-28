import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webreinvent_todo/src/features/todo/data/bloc/todo_bloc.dart';
import 'package:webreinvent_todo/src/features/todo/data/bloc/todo_event.dart';
import 'package:webreinvent_todo/src/features/todo/views/todo_view.dart';

///TodoScreen - Display Todo Screen
class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc()..add(LoadTasks()),
      child: TodoView(),
    );
  }
}
