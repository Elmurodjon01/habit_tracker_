import 'package:flutter/material.dart';
import 'package:habit_tracker_/presentation/main_page.dart';
import 'package:habit_tracker_/providers/db_provider.dart';
import 'package:habit_tracker_/providers/theme_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'constants/const.dart';

void main() async {
  await Hive.initFlutter();
  myBox = await Hive.openBox('habits');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DBProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: provider.currentTheme,
      home: const MainPage(),
    );
  }
}
