import 'package:flutter/material.dart';
import 'package:habit_tracker_/constants/const.dart';

class DBProvider extends ChangeNotifier {
  List<dynamic> habits = [];

  addHabits(String habit) async {
    await myBox.add(habit);
    getHabit();
    notifyListeners();
  }

  getHabit() async {
    habits = myBox.values.toList();
    notifyListeners();
  }
}
