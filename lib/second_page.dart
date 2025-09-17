import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  final Function(String) onAdd;

  const AddTodoPage({super.key, required this.onAdd});

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final TextEditingController _controller = TextEditingController();

void _handleAdd() {
  if (_controller.text.isNotEmpty) {
    widget.onAdd(_controller.text); //Lägg till i listan
    Navigator.pop(context); //tillbaka till första sidan
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG333 TODO"),
        backgroundColor: const Color.fromARGB(255, 141, 86, 208),
        leading: IconButton(
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
              controller: _controller, //koppla controllen
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "What are you going to do?",
              ),
            ),
            SizedBox(height: 20),
            Center(
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
