import 'package:flutter/foundation.dart';
import 'todo_service.dart';
import 'todo.dart';

//Fil för statemanagement

enum FilterOption {all, done, undone} //filteralternativ

class TodoProvider extends ChangeNotifier { //provider som hanterar state för alla todos
  final TodoService service; //service för APIanrop

  FilterOption _filter = FilterOption.all; //default för filtret är all
  FilterOption get filter => _filter; //publik getter för filter

  List<Todo> _todos = []; //privat lista med todos
  bool _isLoading = false; //privat flagga för laddnindsstatus
  String? _error; //privat string för felmeddelande

  TodoProvider(this.service); //konstruktor som tar in en TodoService

  List<Todo> get todos => _todos; //getter för listan med todos
  bool get isLoading => _isLoading; //getter för laddningsflagga
  String? get error => _error; //getter för felmeddelande

  int get totalCount => _todos.length; //gör antal todos totalt
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
    _filter = newFilter; //uppdaterar privat variabel
    notifyListeners(); //meddelar UI:t
  }

  Future<void> loadTodos() async { //hämtar todos från API
    _isLoading = true; //laddningsstatus
    _error = null; //nollstället felmeddelande
    notifyListeners();

    try {
      _todos = await service.getTodos(); //hämtar lista från API:t
    } catch (e) {
      _error = e.toString(); //spara fel
    }

    _isLoading = false; //sluta ladda
    notifyListeners(); //uppdatera UI (eller fel)
  }

  Future<void> addTodo(String title) async { //lägger  till ny todo
    try {
      final newTodo = Todo.create(title); //skapar ny todo
      await service.addTodo(newTodo); //skicka till API
      await loadTodos(); //ladda om listan från API 
    } catch (e) {
      _error = e.toString(); //spara fel
      notifyListeners();
    }
  }

  Future<void> toggleTodo(Todo todo) async { //ändra todos donestatus
    try {
      todo.done = !todo.done; //byter värde
      await service.updateTodo(todo); //uppdaterar servern
      await loadTodos(); //ladda om listan
    } catch (e) {
      _error = e.toString(); //vid fel
      notifyListeners();
    }
  }

  Future<void> removeTodo(Todo todo) async { //Ta bort en todo
    try {
      await service.deleteTodo(todo.id); //Ta bort från servern
      _todos.remove(todo); //ta bort lokalt
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}
