import 'package:flutter/material.dart';
import 'package:habit_tracker_/providers/db_provider.dart';
import 'package:provider/provider.dart';

void popUpDialog(BuildContext context, TextEditingController habitController) {
  final provider = Provider.of<DBProvider>(context, listen: false);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit habit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: habitController,
              decoration: const InputDecoration(
                labelText: 'Enter habit',
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.habits.add(habitController.text);
              habitController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}
