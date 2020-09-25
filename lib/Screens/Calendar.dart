import 'package:flutter/material.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:hacksprintps10quadrabyte/Screens/AddExpense.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController = CalendarController();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    var mainbody = Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: <Widget>[
        Container(
        height: 150,
        width: double.infinity,
        color: Colors.white,
        child: Center(
          child: ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(
              "Log your expenses:",
              style: TextStyle(fontSize: 24),
            ),
            subtitle: Text(
              "Here you can select the exact date for which\nyou would like to log your expenses.",
              style: TextStyle(fontSize: 15),
            ),
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
          print( DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
              .format(date));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExpense(
                      authProvider.user.uid,
                      DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                          .format(date))));
        },
      )
    ]));

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
          backgroundColor: Colors.black87,
          //leading: backbutton,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            "Calendar",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        body: mainbody);
  }
}
