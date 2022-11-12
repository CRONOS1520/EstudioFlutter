import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({super.key});

  @override
  State<MyCalendar> createState() => _MyCalendarSate();
}

class _MyCalendarSate extends State<MyCalendar> {
  TextEditingController calendarController = new TextEditingController();
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 244, 244, 242),
        body: ListView(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TableCalendar(
                selectedDayPredicate: (day) => _selectedDay == day,
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _focusedDay = focusedDay;
                    _selectedDay = selectedDay;
                  });
                },
                firstDay: DateTime.utc(2010, 10, 20),
                lastDay: DateTime.utc(2040, 10, 20),
                focusedDay: _focusedDay,
              ),
            ],
          )
        ]));
  }
}
