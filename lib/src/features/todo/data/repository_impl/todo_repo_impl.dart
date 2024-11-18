import 'package:webreinvent_todo/src/features/todo/data/data_source/todo_data_src.dart';
import 'package:webreinvent_todo/src/features/todo/data/model/todo_model.dart';
import 'package:webreinvent_todo/src/features/todo/domain/entities/todo_entity.dart';
import 'package:webreinvent_todo/src/features/todo/domain/respository/todo_repository.dart';

class TodoRepoImpl implements TodoRepository {
  final TodoDataSrc todoDataSrc;

  TodoRepoImpl({
    required this.todoDataSrc,
  });

  @override
  Future<List<TodoEntity>> getTask({required String keyName}) async => todoDataSrc.getData(keyName: keyName);

  @override
  Future<bool> addTask({
    required String keyName,
    required List<TodoEntity> data,
  }) async {
    final List<TodoModel> modelData = data.map((task) => task as TodoModel).toList();
    return await todoDataSrc.addData(
      keyName: keyName,
      data: modelData,
    );
  }

  @override
  Future<bool> updateTask({
    required String keyName,
    required List<TodoEntity> data,
    required int index,
  }) async {
    final List<TodoModel> modelData = data.map((task) => task as TodoModel).toList();
    return await todoDataSrc.updateTask(
      keyName: keyName,
      data: modelData,
      index: index,
    );
  }
}
