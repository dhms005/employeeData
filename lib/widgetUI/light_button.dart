import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';

/// 📌  UI for Light Button
class LightButton extends StatelessWidget {
  final String text;
  final Color backColor;

  LightButton({
    Key? key,
    required this.text,
    this.backColor = AppColors.lightButtonBgColor,
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
        fontColor: AppColors.mainColor,
        title: text,
        fontSize: 14,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
