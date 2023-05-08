import 'package:flutter/material.dart';
import 'package:habit_tracker_/constants/const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavePreference {
  // to set the mode
  Future<void> setTheme(String theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', theme);
  }

// to get the mode
  Future<String> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('theme').toString();
  }
}

enum ThemeType { light, dark }

//Theme provider
class ThemeProvider extends ChangeNotifier {
  SavePreference pre = SavePreference();
  ThemeData currentTheme = lightTheme;
  ThemeType themeType = ThemeType.light;

  ThemeProvider() {
    setInitialTheme();
  }

  setInitialTheme() {
    ThemeData theme = lightTheme;
    pre.getTheme().then((value) {
      if (value != "null") {
        theme = (value == "dark") ? darkTheme : lightTheme;
      }
      currentTheme = theme;
      themeType = (theme == lightTheme) ? ThemeType.light : ThemeType.dark;
      notifyListeners();
    });
  }

  changeCurrentTheme() {
    if (currentTheme == darkTheme) {
      themeType = ThemeType.light;
      currentTheme = lightTheme;
    } else {
      themeType = ThemeType.dark;
      currentTheme = darkTheme;
    }
    pre.setTheme(themeType.name);
    notifyListeners();
  }
}

//theme data for each theme
// ThemeData darkTheme = ThemeData(
//   useMaterial3: true,
//   primaryColor: Colors.black,
//   brightness: Brightness.dark,
//   scaffoldBackgroundColor: Colors.black,
//   cardTheme: const CardTheme(surfaceTintColor: Color(0xff101820)),
//   fontFamily: "Lato",
//   iconTheme: const IconThemeData(color: Color(0xffcfcfcf)),
//   appBarTheme: AppBarTheme(
//       surfaceTintColor: Colors.black,
//       iconTheme: const IconThemeData(color: Colors.white),
//       titleTextStyle: const TextTheme(
//         headlineMedium: TextStyle(
//           color: Color.fromARGB(255, 252, 248, 248),
//         ),
//         // displayLarge: TextStyle(color: Colors.black),
//         // displaySmall: TextStyle(color: Colors.black),
//         // displayMedium: TextStyle(color: Colors.black),
//         // bodyLarge: TextStyle(color: Colors.black),
//         // bodyMedium: TextStyle(color: Colors.black),
//         // bodySmall: TextStyle(color: Colors.black),
//       ).headlineMedium),
// );
ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  cardTheme: const CardTheme(surfaceTintColor: Color(0xff101820)),
  fontFamily: "Lato",
  iconTheme: const IconThemeData(color: Color(0xffcfcfcf)),
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.black,
    iconTheme: const IconThemeData(color: Colors.white),
    titleTextStyle: const TextTheme(
      headlineMedium: TextStyle(
        color: Color.fromARGB(255, 252, 248, 248),
        fontWeight:
            FontWeight.bold, // Add this line to set the text weight to bold
      ),
    ).headlineMedium?.copyWith(
        color: Colors.black), // Add this line to set the text color to black
  ),
);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xff29b6f6),
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  cardTheme: const CardTheme(surfaceTintColor: Colors.white),
  fontFamily: "Lato",
  appBarTheme: AppBarTheme(
      backgroundColor: appBarColor,
      surfaceTintColor: appBarColor,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle:
          const TextTheme(headlineMedium: TextStyle(color: Colors.black))
              .headlineMedium),
);
