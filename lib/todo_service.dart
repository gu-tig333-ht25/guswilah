import 'dart:convert';
import 'package:http/http.dart' as http;
import 'todo.dart';

class TodoService {
  final String apiKey;
  final String baseUrl = "https://todoapp-api.apps.k8s.gu.se";

  TodoService(this.apiKey);

  Future<List<Todo>> getTodos() async {
    final response = await http.get(Uri.parse("$baseUrl/todos?key=$apiKey"));
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }

  Future<void> addTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse("$baseUrl/todos?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to add todo");
    }
  }

  Future<void> updateTodo(Todo todo) async {
    final response = await http.put(
      Uri.parse("$baseUrl/todos/${todo.id}?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(todo.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to update todo");
    }
  }

  Future<void> deleteTodo(String id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/todos/$id?key=$apiKey"),
    );
    if (response.statusCode != 200) {
      throw Exception("Failed to delete todo");
    }
  }
}
