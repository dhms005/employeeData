import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

/// 📌 Function to show the custom date picker bottom sheet
Future<DateTime?> showCustomDatePicker(BuildContext context) async {
  DateTime selectedDay = DateTime.now();

  return await showModalBottomSheet<DateTime>(
    context: context,
    isScrollControlled: true, // Allows full height modal
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.5, // 50% height of the screen
        maxChildSize: 0.8, // Can expand to 80% height
        minChildSize: 0.4, // Minimum 40% height
        builder: (context, scrollController) {
          return StatefulBuilder(
            builder: (context, setModalState) {
              return SingleChildScrollView(
                controller: scrollController,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 🎯 Quick select buttons
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _quickSelectButton(
                            context,
                            "Today",
                            DateTime.now(),
                                (date) => setModalState(() => selectedDay = date),
                          ),
                          _quickSelectButton(
                            context,
                            "Next Monday",
                            _getNextWeekday(1),
                                (date) => setModalState(() => selectedDay = date),
                          ),
                          _quickSelectButton(
                            context,
                            "Next Tuesday",
                            _getNextWeekday(2),
                                (date) => setModalState(() => selectedDay = date),
                          ),
                          _quickSelectButton(
                            context,
                            "After 1 week",
                            DateTime.now().add(Duration(days: 7)),
                                (date) => setModalState(() => selectedDay = date),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),

                      // 📆 Calendar
                      TableCalendar(
                        focusedDay: selectedDay,
                        firstDay: DateTime.utc(2020, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        calendarStyle: CalendarStyle(
                          selectedDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: HeaderStyle(formatButtonVisible: false),
                        selectedDayPredicate: (day) => isSameDay(day, selectedDay),
                        onDaySelected: (selected, focused) {
                          setModalState(() => selectedDay = selected);
                        },
                      ),

                      // ✅ Save/Cancel buttons
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Cancel", style: TextStyle(fontSize: 16)),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.pop(context, selectedDay),
                            child: Text("Save", style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    },
  );
}

/// 📌 Quick select button function
Widget _quickSelectButton(BuildContext context, String text, DateTime date, Function(DateTime) onSelect) {
  return ElevatedButton(
    onPressed: () => onSelect(date),
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.blue[100],
    ),
    child: Text(text, style: TextStyle(color: Colors.blue[800])),
  );
}

/// 📌 Function to get the next occurrence of a given weekday (e.g., next Monday)
DateTime _getNextWeekday(int weekday) {
  DateTime now = DateTime.now();
  int daysUntilNext = (weekday - now.weekday + 7) % 7;
  return now.add(Duration(days: daysUntilNext == 0 ? 7 : daysUntilNext));
}
