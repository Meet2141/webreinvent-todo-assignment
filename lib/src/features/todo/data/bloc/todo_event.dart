abstract class TodoEvent {}

class AddTask extends TodoEvent {
  final String title;

  AddTask(this.title);
}

class ToggleTaskStatus extends TodoEvent {
  final int index;

  ToggleTaskStatus(this.index);
}

class LoadTasks extends TodoEvent {}
