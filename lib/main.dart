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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const FilterPopUp(),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: todos[index].done,
              onChanged: (value) => _toggleDone(index, value),
            ),
            title: Text(
              todos[index].text,
              style: TextStyle(
                decoration: todos[index].done
                ? TextDecoration.lineThrough //överstrykning vid givet index
                : TextDecoration.none,
              ),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _removeTodo(index), //ta bort todo vid givet index
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
