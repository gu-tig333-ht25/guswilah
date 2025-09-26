import 'package:flutter/material.dart';

class Todo {
  final String text;
  final bool done;

  const Todo(this.text, {this.done = false});

  Todo copyWith({String? text, bool? done}) {
    return Todo(
      text ?? this.text,
      done: done ?? this.done,
    );
  }
}

enum FilterOption { all, done, undone }

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo("Write a book"),
    Todo("Do homework"),
    Todo("Tidy room"),
    Todo("Watch TV"),
    Todo("Nap"),
    Todo("Shop groceries"),
    Todo("Have fun"),
    Todo("Meditate"),
  ];

  FilterOption _filter = FilterOption.all;

  List<Todo> get todos {
    switch (_filter) {
      case FilterOption.done:
        return _todos.where((t) => t.done).toList();
      case FilterOption.undone:
        return _todos.where((t) => !t.done).toList();
      case FilterOption.all:
      default:
        return _todos;
    }
  }

  FilterOption get filter => _filter;

  void addTodo(String text) {
    if (text.trim().isEmpty) return;
    _todos.add(Todo(text.trim()));
    notifyListeners();
  }

  void toggleTodo(int index) {
    final todo = _todos[index];
    _todos[index] = todo.copyWith(done: !todo.done);
    notifyListeners();
  }

  void removeTodoAt(int index) {
    _todos.removeAt(index);
    notifyListeners();
  }

  void setFilter(FilterOption filter) {
    _filter = filter;
    notifyListeners();
  }

  int get completedCount => _todos.where((t) => t.done).length;
  int get totalCount => _todos.length;
}