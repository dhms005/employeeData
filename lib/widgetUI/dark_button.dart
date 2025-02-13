import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:employeedata/utils/appColors.dart';
import 'package:flutter/material.dart';

class DarkButton extends StatelessWidget {
  final String text;
  final Color backColor;

  DarkButton({
    Key? key,
    required this.text,
    this.backColor = AppColors.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: backColor,
      ),
      child: TextRobotoFont(
        fontColor: Colors.white,
        title: text,
        fontSize: 14,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
