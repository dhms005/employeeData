import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/utils/appStrings.dart';
import 'package:employeedata/widgetUI/textRobotoFont.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 📌 UI for Empty Employee
class EmptyEmployee extends StatelessWidget {
  const EmptyEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AppImagePath.imgNoData,
            width: 250,
          ),
          TextRobotoFont(
            title: AppStrings.noEmployeeRecordsFound,
            fontColor: AppColors.editTextColor,
            fontWeight: FontWeight.values[5],
            fontSize: 17,
          )
        ],
      ),
    );
  }
}
