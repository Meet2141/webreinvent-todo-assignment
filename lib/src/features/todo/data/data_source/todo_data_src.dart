import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:webreinvent_todo/src/features/todo/data/model/todo_model.dart';
import 'package:webreinvent_todo/src/features/todo/domain/entities/todo_entity.dart';

class TodoDataSrc {
  Future<SharedPreferences> initialize() async {
    return await SharedPreferences.getInstance();
  }

  Future<List<TodoEntity>> getData({required String keyName}) async {
    final prefs = await initialize();
    final data = prefs.getString(keyName);
    if (data != null) {
      final List<dynamic> decodedTasks = json.decode(data);
      final List<TodoEntity> loadedTasks =
          decodedTasks.map((task) => TodoModel.fromMap(task as Map<String, dynamic>)).toList();
      return loadedTasks;
    } else {
      return [];
    }
  }

  Future<bool> addData({
    required String keyName,
    required List<TodoModel> data,
  }) async {
    final prefs = await initialize();
    final encodedTasks = json.encode(data.map((task) => task.toMap()).toList());
    return prefs.setString(keyName, encodedTasks);
  }

  Future<bool> updateTask({
    required String keyName,
    required List<TodoModel> data,
    required int index,
  }) async {
    final updatedTasks = List<TodoModel>.from(data);
    final toggledTask = updatedTasks[index];
    updatedTasks[index] = TodoModel(!toggledTask.isCompleted, toggledTask.title);
    final prefs = await initialize();
    final encodedTasks = json.encode(updatedTasks.map((task) => task.toMap()).toList());
    return prefs.setString(keyName, encodedTasks);
  }

  Future<void> clearData() async {
    final prefs = await initialize();
    prefs.clear();
  }
}
