import 'package:flutter/material.dart'; //Hämtar designbibliotek

main() { //startpunkt
  runApp(MyApp()); //kör igång appen
}

class MyApp extends StatelessWidget { //huvudwidget
  MyApp({super.key});

  final ThemeData myCustomTheme = ThemeData(
    primaryColor: Colors.purple[900],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.purple,
      brightness: Brightness.light,),
    ); 
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TIG333 TODO",
      theme: myCustomTheme,
      home: TodoListPage(),
      );
  }
}