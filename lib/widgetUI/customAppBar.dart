import 'package:flutter/material.dart';

/// 📌  UI for ActionBar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appTitle;
  final AppBar appBar;
  final List<Widget>? actions;

  const CustomAppBar(
      {super.key, required this.appTitle, required this.appBar, this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          appTitle,
          style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 18,
              fontWeight: FontWeight.w500),
        ),
        actions: actions);
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
