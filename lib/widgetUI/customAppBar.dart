import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appTitle;
  final AppBar appBar;
  final List<Widget>? actions;
  const CustomAppBar({super.key, required this.appTitle, required this.appBar,this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(
        appTitle,
        style: TextStyle(
            fontFamily: 'Roboto', fontSize: 18, fontWeight: FontWeight.values[5]),
      ),
      actions: actions
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
