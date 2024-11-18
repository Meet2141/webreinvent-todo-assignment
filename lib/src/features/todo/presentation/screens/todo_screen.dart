import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webreinvent_todo/src/features/todo/data/data_source/todo_data_src.dart';
import 'package:webreinvent_todo/src/features/todo/data/repository_impl/todo_repo_impl.dart';
import 'package:webreinvent_todo/src/features/todo/domain/usecases/todo_usecase.dart';
import 'package:webreinvent_todo/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:webreinvent_todo/src/features/todo/presentation/bloc/todo_event.dart';
import 'package:webreinvent_todo/src/features/todo/presentation/screens/todo_view.dart';

///TodoScreen - Display Todo Screen
class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(
        todoUseCase: TodoUseCase(
          todoRepository: TodoRepoImpl(
            todoDataSrc: TodoDataSrc(),
          ),
        ),
      )..add(LoadTasks()),
      child: TodoView(),
    );
  }
}
