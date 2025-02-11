import 'package:employeedata/utils/appColors.dart';
import 'package:flutter/widgets.dart';

class TextRobotoFont extends StatelessWidget {
  final String title;
  final bool isBold;
  final bool isItalic;
  final double fontSize;
  final Color fontColor;

  const TextRobotoFont(
      {super.key,
      required this.title,
      this.isBold = false,
      this.isItalic = false,
      this.fontSize = 18,
      this.fontColor = AppColors.mainColor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: fontColor,
        fontSize: fontSize,
        fontFamily: 'Roboto',
        // Specify font family explicitly
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      ),
    );
  }
}
