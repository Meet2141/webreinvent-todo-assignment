import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webreinvent_todo/src/core/constants/string_constants.dart';
import 'package:webreinvent_todo/src/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:webreinvent_todo/src/features/todo/presentation/bloc/todo_event.dart';
import 'package:webreinvent_todo/src/features/todo/presentation/bloc/todo_state.dart';

///AddTaskView - Display Add Task View
class AddTaskView extends StatelessWidget {
  AddTaskView({super.key});

  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    alignLabelWithHint: true,
                    labelText: StringConstants.enterTaskTitle,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  final title = _taskController.text;
                  context.read<TodoBloc>().add(AddTask(title));
                  _taskController.clear();
                },
              ),
            ],
          ),
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, state) {
              if (state.errorMessage != null) {
                return Text(
                  state.errorMessage ?? '',
                  style: TextStyle(color: Colors.red),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
