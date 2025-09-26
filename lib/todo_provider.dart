import 'package:flutter/foundation.dart';
import 'todo_service.dart';
import 'todo.dart';


class TodoProvider extends ChangeNotifier {
  final TodoService service;

  FilterOption _filter = FilterOption.all;
  FilterOption get filter => _filter;

  List<Todo> _todos = [];
  bool _isLoading = false;
  String? _error;

  TodoProvider(this.service);

  List<Todo> get todos => _todos;
  bool get isLoading => _isLoading;
  String? get error => _error;

  int get totalCount => _todos.length;
  int get completedCount => _todos.where((t) => t.done).length;

  List<Todo> get filteredTodos {
    switch (_filter) {
      case FilterOption.done:
        return _todos.where((t) => t.done).toList();
      case FilterOption.undone:
        return _todos.where((t) => !t.done).toList();
      case FilterOption.all:
        return _todos;
    }
  }

  void setFilter(FilterOption newFilter) {
    _filter = newFilter;
    notifyListeners();
  }

  Future<void> loadTodos() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _todos = await service.getTodos();
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    try {
      final newTodo = Todo.create(title);
      await service.addTodo(newTodo);
      await loadTodos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> toggleTodo(Todo todo) async {
    try {
      todo.done = !todo.done;
      await service.updateTodo(todo);
      await loadTodos();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> removeTodo(Todo todo) async {
    try {
      await service.deleteTodo(todo.id);
      _todos.remove(todo);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
