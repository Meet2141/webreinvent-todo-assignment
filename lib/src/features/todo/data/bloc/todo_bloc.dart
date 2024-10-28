import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webreinvent_todo/src/core/constants/shared_pref_constants.dart';
import 'package:webreinvent_todo/src/core/constants/string_constants.dart';
import 'package:webreinvent_todo/src/features/todo/data/model/todo_model.dart';
import 'dart:convert';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoState(tasks: [])) {
    on<LoadTasks>((event, emit) async {
      emit(state.copyWith(status: TodoStatus.loading));
      await _loading();
      final prefs = await SharedPreferences.getInstance();
      final savedTasks = prefs.getString(SharedPrefConstants.task);
      if (savedTasks != null) {
        final List<dynamic> decodedTasks = json.decode(savedTasks);
        final List<TodoModel> loadedTasks =
            decodedTasks.map((task) => TodoModel.fromMap(task as Map<String, dynamic>)).toList();
        emit(state.copyWith(tasks: loadedTasks, status: TodoStatus.fetched));
      } else {
        emit(state.copyWith(status: TodoStatus.fetched));
      }
    });

    on<AddTask>((event, emit) async {
      emit(state.copyWith(status: TodoStatus.loading));
      await _loading();
      if (event.title.trim().isEmpty) {
        emit(state.copyWith(errorMessage: StringConstants.taskCantBeEmpty, status: TodoStatus.failure));
      } else {
        final updatedTasks = List<TodoModel>.from(state.tasks)..add(TodoModel(false, event.title));
        await _saveTasks(updatedTasks);
        emit(state.copyWith(tasks: updatedTasks, status: TodoStatus.success, errorMessage: null));
      }
    });

    on<ToggleTaskStatus>((event, emit) async {
      final updatedTasks = List<TodoModel>.from(state.tasks);
      final toggledTask = updatedTasks[event.index];
      updatedTasks[event.index] = TodoModel(!toggledTask.isCompleted, toggledTask.title);
      await _saveTasks(updatedTasks);
      if (!toggledTask.isCompleted) {
        emit(state.copyWith(tasks: updatedTasks, status: TodoStatus.completed));
      } else {
        emit(state.copyWith(tasks: updatedTasks, status: TodoStatus.incomplete));
      }
    });
  }

  Future<void> _saveTasks(List<TodoModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = json.encode(tasks.map((task) => task.toMap()).toList());
    await prefs.setString(SharedPrefConstants.task, encodedTasks);
  }

  Future<void> _loading() async {
    await Future.delayed(Duration(milliseconds: 300));
  }
}
