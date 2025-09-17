import 'package:flutter/material.dart';
import 'main.dart'; //för filtret

class FilterPopUp extends StatelessWidget {
  const FilterPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Filter todos"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
              children: [
          ListTile(
            title: const Text("All"),
            onTap: () => Navigator.pop(context, FilterOption.all),
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