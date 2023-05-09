import 'package:flutter/material.dart';
import 'package:habit_tracker_/constants/const.dart';
import 'package:habit_tracker_/utils/date_time.dart';

class DBProvider extends ChangeNotifier {
  int countFinished = 0;
  List<dynamic> habits = [];
  Map<DateTime, int> dateForHeatMap = {};

  addHabits(String habit) async {
    await myBox.add(habit);
    getDatabase();
    notifyListeners();
  }

  void loadData() {
    if (myBox.get(todaysDateFormatted()) == null) {
      habits = myBox.get("habit_list");
      int i = 0;
      habits.where((element) {
        if (i < element.length) {
          i++;
        }
        return habits[i][1] = false;
      });
    } else {
      habits = myBox.get(todaysDateFormatted());
    }
    notifyListeners();
  }

  void createDefaultHabits() {
    habits = [
      ['run', false],
      ['walk', true],
    ];
    myBox.put('Start_Date', todaysDateFormatted());
    notifyListeners();
  }

  void getDatabase() async {
    myBox.put(todaysDateFormatted(), habits);
    myBox.put('habit_list', habits);
    totalHabitPercentage();
    loadHeatMap();
    notifyListeners();
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(myBox.get("Start_Date"));
    int daysInBetween = DateTime.now().difference(startDate).inDays;
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );
      double strengthAsPercent = double.parse(
        myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );
      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;
      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };
      dateForHeatMap.addEntries(percentForEachDay.entries);
    }
    notifyListeners();
  }

// void totalHabitPercentage (){
//   int i = 0;
//   habits.where((element) {
//     if (i < element.length){
//       i ++;
//       if (habits[i][1] == true){
//         countFinished++;
//       }

//     }

//   });
// }

  void totalHabitPercentage() {
    int countCompleted = 0;
    for (int i = 0; i < habits.length; i++) {
      if (habits[i][1] == true) {
        countCompleted++;
      }
      notifyListeners();
    }

    String percent = habits.isEmpty
        ? '0.0'
        : (countCompleted / habits.length).toStringAsFixed(1);
    myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }
}
