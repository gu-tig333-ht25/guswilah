import 'package:flutter/material.dart'; //Hämtar designbibliotek

main() { //startpunkt
  runApp(MyApp()); //kör igång appen
}

class MyApp extends StatelessWidget { //huvudwidget
  MyApp({super.key});

  final ThemeData myCustomTheme = ThemeData( //bestäm tema och färg
    primaryColor: Colors.purple[900],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,),
    ); 
 
  @override
  Widget build(BuildContext context) { //bestäm titel och vad som öppnas först
    return MaterialApp(
      title: "TIG333 TODO",
      theme: myCustomTheme,
      home: TodoListPage(),
      );
  }
}

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {//gör listan
    final todos = [
      "Write a book",
      "Do homework",
      "Tidy room",
      "Watch TV",
      "Nap",
      "Shop groceries",
      "Have fun",
      "Meditate",
    ];

    return Scaffold(
      appBar: AppBar( //översta widgeten med titeln på
        title: Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        actions: [ //knappar
          IconButton( //tre prickar på sidan som meny popup
            icon: Icon(Icons.more_vert),
            onPressed: (){
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("all"),
                        Text("done"),
                        Text("undone"),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
  
      body: ListView.builder( // lista baserat på hur många element som finns
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile(
      leading: Checkbox(
        value: false,
        onChanged: (_) {}, // checkbox till vänster
      ),
      title: Text(todos[index]),
      trailing: Icon(Icons.close),
    );
  },
),

            floatingActionButton: FloatingActionButton( //plustecknet på sidan
              onPressed:(){
                Navigator.push(
                  context,
                MaterialPageRoute(builder:(context)=> //öppna nästa sida
                AddTodoPage()), //måste göra klassen
                );
              },
              child: Icon(Icons.add),
            ),
          );
        }
      }

class AddTodoPage extends StatelessWidget { //gör sida 2
  AddTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //Översta widgeten med texten i, samma som som sida 1
        title: Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        leading:IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          ),
        ),

  body: Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "What are you going to do?",
          ),
        ),
        SizedBox(height:20),
        Center(
          child: TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add),
            label: Text("ADD"),
            ),
          ),
        ],
      ),
    ),
  );
}
}