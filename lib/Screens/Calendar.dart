import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    var backbutton =
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: backbutton,
        title: Text(
          "Calendar",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: TableCalendar(
          calendarController: _calendarController,
          calendarStyle: CalendarStyle(outsideDaysVisible: false),
          onDaySelected: (date, events) {
            print(date.toIso8601String());
          },
        ),
      ),
    );
  }
}
