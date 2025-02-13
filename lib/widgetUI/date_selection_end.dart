import 'package:employeedata/utils/appColors.dart';
import 'package:employeedata/utils/appImagePath.dart';
import 'package:employeedata/utils/appStrings.dart';
import 'package:employeedata/widgetUI/dark_button.dart';
import 'package:employeedata/widgetUI/dark_fixed_button.dart';
import 'package:employeedata/widgetUI/display_text_date.dart';
import 'package:employeedata/widgetUI/light_button.dart';
import 'package:employeedata/widgetUI/light_fixed_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelectionEnd extends StatefulWidget {
  final String placeholder;
  final ValueChanged<DateTime?> onDateSelected;
  final double width;
  DateTime? initialDate;
  TextEditingController controller;

  DateSelectionEnd(
      {super.key,
      required this.placeholder,
      required this.onDateSelected,
      required this.width,
      required this.controller,
      this.initialDate});

  @override
  _DateSelectionEndState createState() => _DateSelectionEndState();
}

class _DateSelectionEndState extends State<DateSelectionEnd> {
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
      onTap: () async {
        DateTime? pickedDate = await showFullScreenDatePicker(context);
        // if (pickedDate != null) {
          setState(() {
            selectedDate = pickedDate;
            widget.onDateSelected(pickedDate);
          });
        // }
      },
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

  /// 📌 Function to show full-screen date picker
  Future<DateTime?> showFullScreenDatePicker(BuildContext context) async {
    DateTime? selectedDay = DateTime.now();

    return await showGeneralDialog<DateTime>(
      context: context,
      barrierDismissible: true,
      // Close on tap outside
      barrierLabel: "Date Picker",
      transitionDuration: Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Scaffold(
              backgroundColor: Colors.black54, // Semi-transparent background
              body: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  // height: MediaQuery.of(context).size.height * 0.7,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                        onTap: () => setModalState(
                                            () => selectedDay = null),
                                        child: DarkButton(text: AppStrings.noDate)),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: _quickSelectButton(
                                        context,
                                        AppStrings.today,
                                        DateTime.now(),
                                        (date) => setModalState(
                                            () => selectedDay = date)),
                                  ),
                                ],
                              ),
                              // 📆 Calendar
                              TableCalendar(
                                focusedDay: selectedDay ?? DateTime.now(),
                                selectedDayPredicate: (day) =>
                                    selectedDay != null &&
                                    isSameDay(day, selectedDay),
                                firstDay: DateTime.utc(2020, 1, 1),
                                lastDay: DateTime.utc(2030, 12, 31),
                                // Custom Weekday Text (Sun, Mon, Tue, ...)
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                    fontFamily: 'Roboto', // Apply custom font
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.editTextColor,
                                  ),
                                  weekendStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: AppColors.editTextColor, // Customize weekend color
                                  ),
                                ),

                                calendarStyle: CalendarStyle(
                                  outsideDaysVisible: false,
                                  selectedDecoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                  todayDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: AppColors.mainColor,
                                      // Change to your preferred blue color
                                      width: 1, // Adjust border thickness
                                    ),
                                  ),
                                  todayTextStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    // Specify font family explicitly
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: AppColors.editTextColor, // Keep today's text black when unselected
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  selectedTextStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    // Specify font family explicitly
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    color: Colors.white, // White text for selected date
                                  ),
                                  defaultTextStyle: TextStyle(
                                      fontFamily: 'Roboto',
                                      // Specify font family explicitly
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: AppColors.editTextColor),
                                ),
                                headerStyle: HeaderStyle(
                                  titleCentered: true,
                                  // Center the month title
                                  formatButtonVisible: false,
                                  // Hide format button
                                  titleTextStyle: TextStyle(
                                    fontFamily: 'Roboto', // Set your font
                                    fontSize: 16,
                                    fontWeight: FontWeight.values[5],
                                    color: AppColors.editTextColor,
                                  ),
                                  leftChevronIcon: SvgPicture.asset(
                                    AppImagePath.imgPrevious,
                                    height: 20,
                                    width: 20,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.lightTextColor,
                                        BlendMode.srcIn),
                                  ),
                                  // Custom previous icon
                                  rightChevronIcon: SvgPicture.asset(
                                    AppImagePath.imgNext,
                                    height: 20,
                                    width: 20,
                                    colorFilter: const ColorFilter.mode(
                                        AppColors.lightTextColor,
                                        BlendMode.srcIn),
                                  ),
                                  // headerPadding: EdgeInsets.zero, // Remove padding
                                  // headerMargin: EdgeInsets.symmetric(horizontal: 8), // Reduce space// Custom next icon
                                ),
                                // selectedDayPredicate: (day) =>
                                //     isSameDay(day, selectedDay),
                                onDaySelected: (selected, focused) {
                                  setModalState(() => selectedDay = selected);
                                },
                              ),
                            ],
                          ),
                        ),

                        // SizedBox(height: 16),
                        Container(
                          height: 1,
                          color: AppColors.editTextBorderColor,
                        ),
                        // ✅ Save/Cancel buttons
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DisplayTextDate(
                                  title: (selectedDay != null
                                      ? dateFormat.format(selectedDay!)
                                      : AppStrings.noDate)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // ElevatedButton(
                                  //   onPressed: _saveEmployee,
                                  //   child: Text(widget.employee == null
                                  //       ? "Add Employee"
                                  //       : "Update Employee"),
                                  // ),

                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: LightFixedButton(
                                        text: AppStrings.cancel),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context, selectedDay);
                                    },
                                    child:
                                        DarkFixedButton(text: AppStrings.save),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// 📌 Quick Select Button Widget
  Widget _quickSelectButton(BuildContext context, String text, DateTime? date,
      Function(DateTime?) onSelect) {
    return text == AppStrings.noDate
        ? GestureDetector(
            onTap: () => onSelect(date), child: DarkButton(text: text))
        : GestureDetector(
            onTap: () => onSelect(date), child: LightButton(text: text));
  }
}
