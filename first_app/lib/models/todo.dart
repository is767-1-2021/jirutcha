class Todo {
  final int userId;
  final int id;
  final String title;
  bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  factory Todo.fromJson(
    Map<String, dynamic> json,
  ) {
    return Todo(
      json['userId'] as int,
      json['id'] as int,
      json['title'] as String,
      json['completed'] as bool,
    );
  }
}

class AllTodos {
  final List<Todo> todos;
  AllTodos(this.todos);

  factory AllTodos.fromJson(List<dynamic> json) {
    List<Todo> todos;

    todos = json.map((index) => Todo.fromJson(index)).toList();

    return AllTodos(todos);
  }
}