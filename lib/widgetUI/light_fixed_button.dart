import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';

class LightFixedButton extends StatelessWidget {
  final String text;
  final Color backColor;

  LightFixedButton({
    Key? key,
    required this.text,
    this.backColor = AppColors.lightButtonBgColor,
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
        fontColor: AppColors.mainColor,
        title: text,
        fontSize: 14,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
