import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'second_page.dart';
import 'pop_up.dart';
import 'todo_provider.dart';

void main() { //laddar hela widgetträdet
  runApp(
    ChangeNotifierProvider(
      create: (_) => TodoProvider(),
      child: MyApp(),
    ),
  ); //första widgeten (??)
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

class TodoListPage extends StatelessWidget { //(??)
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context){
    final provider = context.watch<TodoProvider>();
    final todos = provider.todos;
  
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG333 TODO • ${provider.completedCount}/${provider.totalCount} done",),
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
                provider.setFilter(result);
              }
            },
          ),
        ],
      ),

      body: ListView.builder( //skapar listans rader
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile( //standardrad med leading/title/trailing
            leading: Checkbox( //ändrar todo.done
              value: todo.done,
              onChanged: (_) => provider.toggleTodo(index), //anropar _toggleDone med index via todos.indexOf(todo)
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
              onPressed: () => provider.removeTodoAt(index), //ta bort todo
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton( //öppnar AddTodoPage via Navigator.push
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute( //bygger en sida
              builder: (_) => const AddTodoPage( //returnerar den nya widgeten
              )
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
