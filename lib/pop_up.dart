import 'package:flutter/material.dart';

class FilterPopUp extends StatelessWidget {
  const FilterPopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text("all"),
          Text("done"),
          Text("undone"),
        ],
      ),
    );
  }
}
