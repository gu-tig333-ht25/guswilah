import 'package:flutter/material.dart'; //Hämtar designbibliotek

main() { //startpunkt
  runApp(MyApp()); //kör igång appen, börja med klassen MyApp
}

class MyApp extends StatelessWidget { //huvudwidget, har inget minne
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
      home: TodoListPage(), //Visa TodoListPage sidan först
      );
  }
}

class TodoListPage extends StatelessWidget {
  TodoListPage({super.key}); //sida nr.1

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

    return Scaffold( //standardlayout för en sida
      appBar: AppBar( //översta widgeten med titeln på
        title: Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        actions: [ //knappar
          IconButton( //tre prickar på sidan som meny, jag ser den inte pga debuggrejen
            icon: Icon(Icons.more_vert),
            onPressed: (){
              showDialog(
                context: context,
                builder: (context){
                  return AlertDialog( //popup
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
  
      body: ListView.builder( // lista baserat på hur många saker i todos som finns
  itemCount: todos.length,
  itemBuilder: (context, index) {
    return ListTile( //varje rad i listan kommer ha
      leading: Checkbox( //checkbox till vänster
        value: false, //har inget värde än
        onChanged: (_) {},
      ),
      title: Text(todos[index]), //uppgiften man ska göra (text)
      trailing: Icon(Icons.close), //kryss till höger
    );
  },
),

            floatingActionButton: FloatingActionButton( //plustecknet på sidan
              onPressed:(){
                Navigator.push( //gå framåt i historiken
                  context,
                MaterialPageRoute(builder:(context)=> //öppna nästa sida
                AddTodoPage()),
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
        leading:IconButton( //tillbaka pil
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context), //tillbaka till sida 1
          ),
        ),

  body: Padding(
    padding: EdgeInsets.all(20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField( //ruta att skriva ny uppgift i
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "What are you going to do?",
          ),
        ),
        SizedBox(height:20),
        Center(
          child: TextButton.icon( //knapp för att lägga till i listan på sida 1
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