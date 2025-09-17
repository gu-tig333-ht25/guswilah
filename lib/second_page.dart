import 'package:flutter/material.dart';

class AddTodoPage extends StatelessWidget {
  AddTodoPage({super.key});

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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "What are you going to do?",
              ),
            ),
            SizedBox(height: 20),
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
