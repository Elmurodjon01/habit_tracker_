import 'package:flutter/material.dart';
import 'package:habit_tracker_/providers/db_provider.dart';
import 'package:habit_tracker_/providers/theme_provider.dart';
import 'package:habit_tracker_/utils/widgets/addButton.dart';
import 'package:habit_tracker_/utils/widgets/habit_container.dart';
import 'package:habit_tracker_/utils/widgets/popup_dialog.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController habitController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<DBProvider>(context, listen: false);
      provider.getHabit();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final dbProvider = Provider.of<DBProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.light,
            color: Colors.white,
          ),
          onPressed: () => provider.changeCurrentTheme(),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ListView.builder(
            itemCount: dbProvider.habits.length,
            itemBuilder: (context, index) {
              var data = dbProvider.habits[index];
              return ItemContainer(
                habit: data,
                onTap: () => popUpDialog(context, habitController),
              );
            },
          ),
          AddButton(context, habitController),
        ],
      ),
    );
  }
}
