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
      appBar: Appbar(
        title: Text("TIG333 TODO"),
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
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
  } //här är det helt klart nått knas
  }