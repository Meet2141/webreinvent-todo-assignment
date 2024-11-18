import 'package:webreinvent_todo/src/features/todo/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTask({
    required String keyName,
  });

  Future<bool> addTask({
    required String keyName,
    required List<TodoEntity> data,
  });

  Future<bool> updateTask({
    required String keyName,
    required List<TodoEntity> data,
    required int index,
  });
}
