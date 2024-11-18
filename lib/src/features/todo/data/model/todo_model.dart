import 'package:webreinvent_todo/src/features/todo/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  TodoModel(
    super.isCompleted,
    super.title,
  );

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      map['isCompleted'] as bool,
      map['title'] as String,
    );
  }
}
