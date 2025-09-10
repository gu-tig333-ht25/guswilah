import 'package:flutter/material.dart'; //Hämtar designbibliotek

main() { //startpunkt
  runApp(MyApp()); //kör igång appen
}

class MyApp extends StatelessWidget { //huvudwidget
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TIG333 TODO",
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: TodoListPage(),
      );
  }
}