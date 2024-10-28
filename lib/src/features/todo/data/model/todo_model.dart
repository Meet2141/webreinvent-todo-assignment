class TodoModel {
  final String title;
  final bool isCompleted;

  TodoModel(
    this.isCompleted,
    this.title,
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
