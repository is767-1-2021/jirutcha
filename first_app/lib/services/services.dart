import 'dart:convert';

import 'package:first_app/models/todo.dart';
import 'package:http/http.dart';

class HttpServices {
  Client client = Client();

  Future<List<Todo>> getTodos() async {
    final response = await client.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/todos',
    ));

    if (response.statusCode == 200) {
      var all = AllTodos.fromJson(
        json.decode(response.body),
      );

      return all.todos;
    }

    throw Exception('Failed to load todos');
  }
}