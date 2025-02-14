import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 📌  UI for Display Current Date/No Date in Calender
class DisplayTextDate extends StatelessWidget {
  final String title;

  const DisplayTextDate({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          AppImagePath.imgEvent2,
          height: 24,
          width: 24,
          colorFilter:
              const ColorFilter.mode(AppColors.mainColor, BlendMode.srcIn),
        ),
        SizedBox(width: 6), // Space between icon and text
        TextRobotoFont(
          title: title,
          fontSize: 14,
          fontColor: AppColors.editTextColor,
        )
      ],
    );
  }
}
