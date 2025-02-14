import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';

/// 📌 UI for Employee Section Title
class EmployeeSectionTitle extends StatelessWidget {
  final String title;

  const EmployeeSectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: TextRobotoFont(
        title: title,
        fontColor: AppColors.mainColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
