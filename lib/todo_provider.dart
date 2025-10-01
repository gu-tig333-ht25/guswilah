import 'package:flutter/foundation.dart';
import 'todo_service.dart';
import 'todo.dart';

//Fil för statemanagement

enum FilterOption {all, done, undone} //filteralternativ

class TodoProvider extends ChangeNotifier { //provider som hanterar state för alla todos
  final TodoService service; //service för APIanrop

  FilterOption _filter = FilterOption.all; //default för filtret är all
  FilterOption get filter => _filter; 

  List<Todo> _todos = []; 
  bool _isLoading = false;
  String? _error; 

  TodoProvider(this.service); 

  List<Todo> get todos => _todos; //getter för listan med todos
  bool get isLoading => _isLoading; 
  String? get error => _error;

  int get totalCount => _todos.length; 
  int get completedCount => _todos.where((t) => t.done).length; //antal todos som är gjorda

  List<Todo> get filteredTodos { //returnerar lista beroende på filtret
    switch (_filter) {
      case FilterOption.done:
        return _todos.where((t) => t.done).toList();
      case FilterOption.undone:
        return _todos.where((t) => !t.done).toList();
      case FilterOption.all:
        return _todos;
    }
  }

  void setFilter(FilterOption newFilter) { //ändrar filter
    _filter = newFilter; 
    notifyListeners(); 
  }

  Future<void> loadTodos() async { //hämtar todos från API
    _isLoading = true; 
    _error = null; 
    notifyListeners();

    try {
      _todos = await service.getTodos(); //hämtar lista från API:t
    } catch (e) {
      _error = e.toString(); //spara fel
    }

    _isLoading = false; //sluta ladda
    notifyListeners(); 
  }

  Future<void> addTodo(String title) async { //lägger  till ny todo
    try {
      final newTodo = Todo.create(title); 
      await service.addTodo(newTodo); 
      await loadTodos();  
    } catch (e) {
      _error = e.toString(); //spara fel
      notifyListeners();
    }
  }

  Future<void> toggleTodo(Todo todo) async { //ändra todos donestatus
    try {
      todo.done = !todo.done; 
      await service.updateTodo(todo); 
      await loadTodos(); 
    } catch (e) {
      _error = e.toString(); 
      notifyListeners();
    }
  }

  Future<void> removeTodo(Todo todo) async { //Ta bort en todo
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
