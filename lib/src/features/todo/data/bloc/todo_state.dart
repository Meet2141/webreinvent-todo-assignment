import 'package:webreinvent_todo/src/features/todo/data/model/todo_model.dart';

enum TodoStatus { initial, loading, success, fetched, completed, incomplete, failure }

class TodoState {
  final List<TodoModel> tasks;
  final String? errorMessage;
  final TodoStatus status;

  TodoState({
    required this.tasks,
    this.errorMessage,
    this.status = TodoStatus.initial,
  });

  TodoState copyWith({
    List<TodoModel>? tasks,
    String? errorMessage,
    TodoStatus? status,
  }) {
    return TodoState(
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage,
      status: status ?? this.status,
    );
  }
}
