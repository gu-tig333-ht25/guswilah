import 'package:flutter/material.dart';
import 'second_page.dart';
import 'pop_up.dart';

void main() { //laddar hela widgetträdet
  runApp(MyApp()); //första widgeten
}

class MyApp extends StatelessWidget { //oföränderlig widget
  MyApp({super.key}); //konstruktor som kan använda valfri key ayy skicka vidare

  final ThemeData myCustomTheme = ThemeData( //bestämmer huvudtema och färger
    primaryColor: Colors.purple[900],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,
    ),
  );

  @override
  Widget build(BuildContext context) { //returnera MaterialApp som är grunden i UI:t
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TIG333 TODO",
      theme: myCustomTheme,
      home: TodoListPage(), //sidan som visas först
    );
  }
}

class Todo { //klass som håller varje todo task
  String text; //texten som beskriver todo:n
  bool done; //bool som kan spara om todo:n är done eller inte

  Todo(this.text, {this.done = false}); //konstruktor som skapat todo:n och ger basvärdet not done
}

enum FilterOption {all, done, undone} //uppsättning namngivna värden för filtreringen

class TodoListPage extends StatefulWidget { //Stateful för att listan ska kunna ändras
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();//kopplar widgeten till sin state-klass (_TodoListPageState)
}

class _TodoListPageState extends State<TodoListPage> { //klass med todo:s i när man öppnar appen, kanske ska ta bort?
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

  FilterOption currentFilter = FilterOption.all; //håller i filtret som är aktivt, flytta på?

  void _addTodo (String newTodo) { //funktion för att lägga till ny todo
    setState(() { //state förändras, bygger om UI
      todos.add(Todo(newTodo));
    });
  }

  void _toggleDone(int index, bool? value){ //klass för att kunna stryka över via checkbox
    setState(() {
      todos[index].done = value ?? false;
    });
  }

  void _removeTodo(int index) { //klass för att ta bort task via krysset och uppdatera UI
    setState(() {
      todos.removeAt(index); //ta bort todo vid givet index
    });
  }

  List<Todo> get filteredTodos { //getter som returnerar en filtrerad lista beroende  på currentFilter
    switch (currentFilter) {
      case FilterOption.done:
      return todos.where((t) => t.done).toList(); //toList gör det till en lista
      case FilterOption.undone:
      return todos.where((t) => !t.done).toList();
      case FilterOption.all:
      default:
      return todos;
    }
  }

  void _setFilter(FilterOption filter) { //sätter nytt filter och anropar setState så listan uppdateras
    setState(() {
      currentFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) { //Scaffold gör grundlayouten
    return Scaffold(
      appBar: AppBar(
        title: const Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        actions: [ //tre prickar för popup filtret
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

      body: ListView.builder( //skapar listans rader
        itemCount: filteredTodos.length,
        itemBuilder: (context, index) {
          final todo = filteredTodos[index];
          return ListTile( //standardrad med leading/title/trailing
            leading: Checkbox( //ändrar todo.done
              value: todo.done,
              onChanged: (value) => _toggleDone(todos.indexOf(todo), value), //anropar _toggleDone med index via todos.indexOf(todo)
            ),
            title: Text( //visar uppgiftstexten
              todo.text,
              style: TextStyle(
                decoration: todo.done
                ? TextDecoration.lineThrough //överstrykning
                : TextDecoration.none,
              ),
            ),
            trailing: IconButton( //krysset tar bort todo via index
              icon: const Icon(Icons.close),
              onPressed: () => _removeTodo(todos.indexOf(todo)), //ta bort todo
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton( //öppnar AddTodoPage via Navigator.push
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute( //bugger en sida
              builder: (context) => AddTodoPage( //returnerar den nya widgeten
                onAdd: _addTodo, //skicka med callbacken onAdd som AddTodoPage kan anropa för att lägga till en ny todo
              )
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
