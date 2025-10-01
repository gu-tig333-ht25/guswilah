import 'package:flutter/material.dart';
import 'todo.dart';

class FilterPopUp extends StatelessWidget { //stateless för popupen aldrig ändras
  const FilterPopUp({super.key}); //const = oföränderlig konstruktor

  @override
  Widget build(BuildContext context) { //bygger UI:t, context för att veta vart i trädet vi är
    return AlertDialog( //inbyggd popupwidget
      title: const Text("Filter todos"),
      content: Column( //visar alternativen i popupen
        mainAxisSize: MainAxisSize.min,
              children: [
          ListTile(
            title: const Text("All"), //texten som står
            onTap: () => Navigator.pop(context, FilterOption.all), //vid tryck stäng popup och returnera värdet till TodoListPage
          ),
          ListTile(
            title: const Text("Done"),
            onTap: () => Navigator.pop(context, FilterOption.done),
          ),
          ListTile(
            title: const Text("Undone"),
            onTap: () => Navigator.pop(context, FilterOption.undone),
          ),
        ],
      ),
    );
  }
}