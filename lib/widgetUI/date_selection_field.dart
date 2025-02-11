import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DateSelectionField extends StatefulWidget {
  final String placeholder;
  final ValueChanged<DateTime?> onDateSelected;
  final double width;
  DateTime? initialDate;

  DateSelectionField(
      {required this.placeholder,
      required this.onDateSelected,
      required this.width,this.initialDate});

  @override
  _DateSelectionFieldState createState() => _DateSelectionFieldState();
}

class _DateSelectionFieldState extends State<DateSelectionField> {
  DateTime? selectedDate;
  final DateFormat dateFormat = DateFormat('d MMM yyyy');

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _pickDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDate(context),
      child: Container(
        width: widget.width,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.editTextBorderColor),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(0), // Adjust padding if needed
              child: SvgPicture.asset(
                AppImagePath.imgEvent2,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                    AppColors.mainColor, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                selectedDate != null
                    ? dateFormat.format(selectedDate!)
                    : widget.placeholder,
                style: TextStyle(
                  color: selectedDate != null ? Colors.black : Colors.grey,
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
