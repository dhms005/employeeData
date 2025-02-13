import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:employeedata/utils/appColors.dart';
import 'package:flutter/material.dart';

class DarkFixedButton extends StatelessWidget {
  final String text;
  final Color backColor;

  DarkFixedButton({
    Key? key,
    required this.text,
    this.backColor = AppColors.mainColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 73,
      padding: EdgeInsets.only(top: 13, bottom: 13, left: 5, right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: backColor,
      ),
      child: TextRobotoFont(
        fontColor: Colors.white,
        title: text,
        fontSize: 14,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
