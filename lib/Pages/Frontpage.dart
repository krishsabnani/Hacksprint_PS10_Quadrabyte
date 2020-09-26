import 'package:bezier_chart/bezier_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacksprintps10quadrabyte/Pages/page_host.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:hacksprintps10quadrabyte/Providers/expense_provider.dart';
import 'package:hacksprintps10quadrabyte/Screens/AddExpense.dart';
import 'package:hacksprintps10quadrabyte/Screens/report.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dashboard.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  final fromDate = DateTime.now().subtract(Duration(days: 6));
  final toDate = DateTime.now();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider<ExpenseProvider>(
      create: (context) => ExpenseProvider(authProvider.user),
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("add todays statement");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddExpense(
                        authProvider.user.uid,
                        DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
                            .format(DateTime.now()))));
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: Colors.black87,
        ),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 40),
                  color: Colors.black87,
                  //width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Welcome, " + authProvider.user.name,
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold)),
                              overflow: TextOverflow.clip,
                            ),
                            width: MediaQuery.of(context).size.width/1.2,
                          ),
//                    SizedBox(
//                      height: 4,
//                    ),
                          Text(
                            "User Dashboard",
                            style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                    color: Color(0xffa29aac),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  child: Container(
                    height: 30,
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Monthly Income : ",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                        ),
                        Text(
                          "₹ " + authProvider.user.income.toString(),
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black12,
                  thickness: 1,
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10),
                    child: Text(
                      "Expenses (Last 7 days) :",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                              fontWeight: FontWeight.w400)),
                    ),
                  ),
                ),

                Consumer<ExpenseProvider>(builder: (context, provider, child) {
                  if (provider.isLoading) {
                    return CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                    );
                  } else {
                    return Container(
                      //color: Colors.white,
                      //padding: EdgeInsets.only(left: 30, right: 30),
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: BezierChart(
                        fromDate: fromDate,
                        bezierChartScale: BezierChartScale.WEEKLY,
                        //xAxisCustomValues: const [5, 10, 15, 20, 25, 30, 35],
                        toDate: toDate,
                        selectedDate: toDate,
                        series: [
                          BezierLine(
                            label: "Spent",
                            lineColor: Colors.lightGreen,
                            data: provider.reqGraphList
                          ),
                        ],
                        config: BezierChartConfig(
                          displayLinesXAxis: true,
                          startYAxisFromNonZeroValue: true,
                          updatePositionOnTap: true,
                          snap: true,
                          displayYAxis: false,
                          stepsYAxis: 3,
                          bubbleIndicatorColor: Colors.white70,
                          verticalIndicatorStrokeWidth: 3.0,
                          verticalIndicatorColor: Colors.black38,
                          showVerticalIndicator: true,
                          verticalIndicatorFixedPosition: false,
                          footerHeight: 80.0,
                          showDataPoints: true,
                          yAxisTextStyle: TextStyle(color: Colors.black),
                          xAxisTextStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    );
                  }
                }),

                Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Card(
                    elevation: 10,
                    child: Container(

                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Card(
                              elevation: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 49,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Expected Monthly Savings: ",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Text(
                                      "₹ " +
                                          authProvider.user.saveAmt
                                              .toStringAsFixed(2),
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Card(
                              elevation: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      "Daily Allowed Expense: ",
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Text(
                                      "₹ " +
                                          authProvider.user.dailyAllowed
                                              .toStringAsFixed(2),
                                      style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                              color: Colors.green,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Card(
                                    elevation: 3,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2.6,
                                      height: 120,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Add Special\nEvent Income: ",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600)),
                                          ),
                                          Center(
                                            child: IconButton(
                                              onPressed: () {
                                                _showDialogSpecialEvent(
                                                    authProvider);
                                              },
                                              icon: Icon(
                                                Icons.monetization_on,
                                                color: Colors.lightGreen,
                                                size: 40,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Card(
                                    elevation: 3,
                                    child: Container(
                                      width:
                                          MediaQuery.of(context).size.width / 2.6,
                                      height: 120,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "View Your\nReport: ",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600)),
                                          ),
                                          Center(
                                            child: IconButton(
                                              onPressed: (){
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => PageHost(2)));
                                              },
                                              icon: Icon(
                                                Icons.insert_drive_file,
                                                color: Colors.lightGreen,
                                                size: 40,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
                //GridDashboard()
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDialogSpecialEvent(AuthProvider authProvider) {
    print("presssssssssss");
    //Dailog box for review
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Center(
              child: Text(
                "Enter special event income:",
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                        color: Colors.black87,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            content: Container(
              //height: height/3.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    //height: height / 4.6,
                    width: 300,
                    child: Form(
                      key: _formKey,
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              //controller: textControllers[0],
                              onSaved: (val) {
                                authProvider.user.specialEvent =
                                    double.parse(val);
                              },
                              validator: (val) {
                                if (val.isEmpty) {
                                  return "Please enter a value";
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Special Event Income",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  // borderRadius:  BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                                //fillColor: Colors.green
                              ),
                              keyboardType: TextInputType.multiline,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // usually buttons at the bottom of the dialog
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Center(
                      child: FlatButton(
                        child: Container(
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.green),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: GoogleFonts.openSans(
                                  textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          _formKey.currentState.save();
                          print(authProvider.user.specialEvent);

                          Firestore.instance
                              .collection("User")
                              .document(authProvider.user.uid)
                              .updateData({
                            "specialEvent": FieldValue.increment(
                                authProvider.user.specialEvent),
                            "saveAmt": FieldValue.increment(
                                authProvider.user.specialEvent)
                          }).then((_) {
                            print("success!");
                          });

                          setState(() {
                            authProvider.user.saveAmt =
                                authProvider.user.saveAmt +
                                    authProvider.user.specialEvent;
                          });

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
