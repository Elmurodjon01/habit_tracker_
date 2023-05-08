import 'package:flutter/material.dart';
import 'package:habit_tracker_/constants/const.dart';
import 'package:habit_tracker_/utils/widgets/popup_dialog.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

Container AddButton(
    BuildContext context, TextEditingController habitController) {
  final provider = Provider.of<ThemeProvider>(context);
  return Container(
    margin: const EdgeInsets.only(bottom: 50),
    height: 50,
    width: 90,
    decoration: BoxDecoration(
      color: appBarColor,
      //TODO: come here
      // provider.themeMode == provider.isDarkMode ? Colors.grey : Colors.orange,
      borderRadius: BorderRadius.circular(20),
    ),
    child: IconButton(
      onPressed: () {
        popUpDialog(context, habitController);
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    ),
  );
}
