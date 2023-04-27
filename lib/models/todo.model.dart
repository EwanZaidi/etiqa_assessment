class Todo {
  String title;
  String startDate;
  String endDate;
  bool completed;

  Todo(
      {required this.title,
      required this.startDate,
      required this.endDate,
      required this.completed});

  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
        title: data['title'],
        startDate: data['startDate'],
        endDate: data['endDate'],
        completed: data['completed']);
  }
}

class TodoList {
  static List<Todo> fromMap(List<dynamic> data) {
    List<Todo> todos = [];
    for (var e in data) {
      final todo = Todo.fromJson(e);
      todos.add(todo);
    }
    return todos;
  }
}
