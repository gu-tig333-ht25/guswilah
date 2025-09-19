import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget { //Stateful för att ta emot användaens text, föränderlig
  final Function(String) onAdd; //tar emot callbackfunktionen (TodolistPage skickar in _addTodo, när onAdd anropas uppdateras listanm)

  const AddTodoPage({super.key, required this.onAdd}); //konstruktor, måste ha onAdd med

  @override
  State<AddTodoPage> createState() => _AddTodoPageState(); //kopplar till _AddTodoPageState där logiken är
}

class _AddTodoPageState extends State<AddTodoPage> { //funktionaliteten
  final TextEditingController _controller = TextEditingController(); //håller koll på TextField

void _handleAdd() {
  if (_controller.text.isNotEmpty) { //får inte vara tom
    widget.onAdd(_controller.text); //Anropar TodoListPage, lägg till i listan
    Navigator.pop(context); //tillbaka till första sidan
  }
}

  @override
  Widget build(BuildContext context) { //Bygger sidans UI varje gång något ändras
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        leading: IconButton( //pil tillbaka till sida 1
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0), //20 pixlar runt allt
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, //widgets tar upp hela bredden
          children: [
            TextField( //skriva in ny todo
              controller: _controller, //koppla med TextEditingController
              decoration: InputDecoration(
                border: OutlineInputBorder(), //ram
                hintText: "What are you going to do?",
              ),
            ),
            SizedBox(height: 20), //plats mellan text och knapp
            Center( //knappen för att lägga till ny todo
              child: TextButton.icon(
                onPressed: _handleAdd,
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
