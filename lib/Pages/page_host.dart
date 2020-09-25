import 'package:flutter/material.dart';
import 'package:hacksprintps10quadrabyte/Pages/Frontpage.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:hacksprintps10quadrabyte/Screens/Calendar.dart';
import 'package:hacksprintps10quadrabyte/Screens/report.dart';
import 'package:provider/provider.dart';

class PageHost extends StatefulWidget {
  int index;
  PageHost(this.index);
  @override
  _PageHostState createState() => _PageHostState(index);
}

class _PageHostState extends State<PageHost> {
  _PageHostState(this._selectedIndex);
  int _selectedIndex;
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Calendar(),
    Report(),
  ];
  //service provider
  @override
  Widget build(BuildContext context) {
    AuthProvider user = Provider.of<AuthProvider>(context);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items:  <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.calendar_today),
              title: Text('Calendar'),
            ),
            BottomNavigationBarItem(
              backgroundColor:Colors.white,
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),

          ],
          currentIndex: _selectedIndex,
          backgroundColor: Colors.black87,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.green,
          onTap: (index) {
            if (_selectedIndex == index) {
              print("already here");
            } else if (index == 1) {

              setState(() {
                _selectedIndex = index;
              });
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
        ),
      ),
    );
  }
}