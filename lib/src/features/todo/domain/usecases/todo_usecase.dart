import 'package:webreinvent_todo/src/features/todo/domain/entities/todo_entity.dart';
import 'package:webreinvent_todo/src/features/todo/domain/respository/todo_repository.dart';

class TodoUseCase {
  final TodoRepository todoRepository;

  TodoUseCase({
    required this.todoRepository,
  });

  Future<List<TodoEntity>> loadTask({required String keyName}) async {
    return todoRepository.getTask(keyName: keyName);
  }

  Future<bool> saveTask({
    required String keyName,
    required List<TodoEntity> data,
  }) async {
    return todoRepository.addTask(keyName: keyName, data: data);
  }

  Future<bool> updateTask({
    required String keyName,
    required List<TodoEntity> data,
    required int index,
  }) async {
    return todoRepository.updateTask(
      keyName: keyName,
      data: data,
      index: index,
    );
  }
}
