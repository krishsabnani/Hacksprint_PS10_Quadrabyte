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
    var mainbody = Column(children: <Widget>[
      Container(
        height: 150,
        width: double.infinity,
        child: Card(
          elevation: 0,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const ListTile(
                leading: Icon(Icons.account_box),
                title: Text(
                  "The expense addition page!",
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  "Here, you can pick and choose the exact amount you want to add for the categories!",
                  style: TextStyle(fontSize: 15),
                ),
              )
            ],
          ),
        ),
      ),
      TableCalendar(
        calendarController: _calendarController,
        calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            selectedColor: Colors.black,
            todayColor: Colors.grey,
            weekendStyle: TextStyle(color: Colors.green),
            todayStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
            )),
        onDaySelected: (date, events) {
          print(date.toIso8601String());
        },
      )
    ]);

    var backbutton = IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        color: Colors.white,
      ),
      onPressed: null,
      //color: Colors.white,
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: backbutton,
          title: Text(
            "Calendar",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: mainbody);
  }
}
