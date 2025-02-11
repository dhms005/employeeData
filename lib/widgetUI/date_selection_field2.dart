import 'package:employeedata/utils/appColors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateRangePicker2 extends StatefulWidget {
  @override
  _DateRangePickerState createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker2> {
  DateTime? startDate;
  DateTime? endDate;
  final DateFormat dateFormat = DateFormat('yMMMd');

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double fieldWidth =
        (MediaQuery.of(context).size.width - 100) / 2; // Adjusting width

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Start Date Picker
        GestureDetector(
          onTap: () => _pickDate(context, true),
          child: _buildDateContainer(
            width: fieldWidth,
            icon: Icons.calendar_today,
            text: startDate != null ? dateFormat.format(startDate!) : "Today",
            isSelected: startDate != null,
          ),
        ),

        // Arrow Icon in Center
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.arrow_forward, color: Colors.blue, size: 24),
        ),

        // End Date Picker
        GestureDetector(
          onTap: () => _pickDate(context, false),
          child: _buildDateContainer(
            width: fieldWidth,
            icon: Icons.calendar_today,
            text: endDate != null ? dateFormat.format(endDate!) : "No date",
            isSelected: endDate != null,
          ),
        ),
      ],
    );
  }

  Widget _buildDateContainer(
      {required double width,
      required IconData icon,
      required String text,
      required bool isSelected}) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.editTextBorderColor, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.mainColor),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.grey,
                fontSize: 16,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
