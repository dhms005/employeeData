import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appTitle;
  final AppBar appBar;

  const CustomAppBar({super.key, required this.appTitle, required this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(appTitle),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
