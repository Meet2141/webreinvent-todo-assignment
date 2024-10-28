import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webreinvent_todo/src/core/constants/string_constants.dart';
import 'package:webreinvent_todo/src/core/utils/toast_utils.dart';
import 'package:webreinvent_todo/src/features/todo/data/bloc/todo_bloc.dart';
import 'package:webreinvent_todo/src/features/todo/data/bloc/todo_event.dart';
import 'package:webreinvent_todo/src/features/todo/data/bloc/todo_state.dart';

///ListTaskView - Display Listview of todo list
class ListTaskView extends StatelessWidget {
  const ListTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<TodoBloc, TodoState>(
        listener: (context, state) {
          if (state.status == TodoStatus.fetched) {
            ToastUtils.showToast(StringConstants.dataFetched);
          } else if (state.status == TodoStatus.completed) {
            ToastUtils.showToast(StringConstants.taskCompleted);
          } else if (state.status == TodoStatus.incomplete) {
            ToastUtils.showToast(StringConstants.taskIncomplete);
          } else if (state.status == TodoStatus.success) {
            ToastUtils.showToast(StringConstants.dataAddedSuccessfully);
          }
        },
        builder: (context, state) {
          if (state.status == TodoStatus.loading) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.tasks.length,
            itemBuilder: (context, index) {
              final task = state.tasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                    context.read<TodoBloc>().add(ToggleTaskStatus(index));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
