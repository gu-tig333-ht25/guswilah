import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'todo_provider.dart';

class AddTodoPage extends StatefulWidget { //Stateful för att ta emot användaens text, föränderlig
  const AddTodoPage({super.key});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState(); //kopplar till _AddTodoPageState där logiken är
}

class _AddTodoPageState extends State<AddTodoPage> { //funktionaliteten
  final TextEditingController _controller = TextEditingController(); //håller koll på TextField

void _handleAdd() { //kommentarer needed
  final text = _controller.text;
  if (text.isNotEmpty) {
    context.read<TodoProvider>().addTodo(text);
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(), //ram
                hintText: "What are you going to do?",
              ),
              onSubmitted: (_) => _handleAdd(),
            ),
            const SizedBox(height: 20), //plats mellan text och knapp
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
