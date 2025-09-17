import 'package:flutter/material.dart';
import 'second_page.dart';
import 'pop_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData myCustomTheme = ThemeData(
    primaryColor: Colors.purple[900],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TIG333 TODO",
      theme: myCustomTheme,
      home: TodoListPage(),
    );
  }
}

class Todo {
  String text;
  bool done;

  Todo(this.text, {this.done = false});
}

enum FilterOption {all, done, undone}

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<Todo> todos = [
    Todo("Write a book"),
    Todo("Do homework"),
    Todo("Tidy room"),
    Todo("Watch TV"),
    Todo("Nap"),
    Todo("Shop groceries"),
    Todo("Have fun"),
    Todo("Meditate"),
  ];

  FilterOption currentFilter = FilterOption.all;

  void _addTodo (String newTodo) {
    setState(() {
      todos.add(Todo(newTodo));
    });
  }

  void _toggleDone(int index, bool? value){ //klass för att kunna stryka över via checkbox
    setState(() {
      todos[index].done = value ?? false;
    });
  }

  void _removeTodo(int index) { //klass för att ta bort task via krysset
    setState(() {
      todos.removeAt(index); //ta bort todo vid givet index
    });
  }

  List<Todo> get filteredTodos { //filtreringen
    switch (currentFilter) {
      case FilterOption.done:
      return todos.where((t) => !t.done).toList();
      case FilterOption.undone:
      return todos.where((t) => !t.done).toList();
      case FilterOption.all:
      default:
      return todos;
    }
  }

  void _setFilter(FilterOption filter) {
    setState(() {
      currentFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () async {
              final result = await showDialog<FilterOption>(
                context: context,
                builder: (context) => const FilterPopUp(),
              );
              if (result != null) {
                _setFilter(result);
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredTodos.length,
        itemBuilder: (context, index) {
          final todo = filteredTodos[index];
          return ListTile(
            leading: Checkbox(
              value: todo.done,
              onChanged: (value) => _toggleDone(todos.indexOf(todo), value),
            ),
            title: Text(
              todo.text,
              style: TextStyle(
                decoration: todo.done
                ? TextDecoration.lineThrough //överstrykning
                : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _removeTodo(todos.indexOf(todo)), //ta bort todo
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodoPage(
                onAdd: _addTodo, //skicka med callback
              )
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
