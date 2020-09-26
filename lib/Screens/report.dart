import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacksprintps10quadrabyte/Pages/opening_screen.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:hacksprintps10quadrabyte/Providers/expense_provider.dart';
import 'package:provider/provider.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        //leading: backbutton,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),

        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.power_settings_new, size: 24, color: Colors.white,),
            onPressed: (){
              authProvider.logout();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => OpeningView()));
            },


          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[

              Card(
                elevation: 3,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                      "User Details: ",
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              color: Colors.black87,
                              fontSize: 22,
                              fontWeight: FontWeight.w400)),
                ),
                    ),
                  ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.green,),
                      title: Text(
                        authProvider.user.name,
                        style: TextStyle(
                          fontSize: 20,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                      subtitle: Text(authProvider.user.email),
                    ),

                  ],
                ),
              ),
              /*Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListTile(
                  leading: Icon(Icons.email),
                  title: Text("Email"),
                  subtitle: Text("User email here"),
                ),
              ),
              */
              Padding(
                padding: EdgeInsets.only(top: 20, left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Overview: ",
                    style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.black87,
                            fontSize: 22,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15.0, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "Income",
                                style: TextStyle(
                                    fontSize: 18, fontStyle: FontStyle.normal),
                              ),
                              Text(
                                "₹ " + authProvider.user.income.toStringAsFixed(2),
                                style: TextStyle(fontSize: 18,color: Colors.green),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5.0, 20, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Expense",
                                  style: TextStyle(
                                      fontSize: 18, fontStyle: FontStyle.normal)),
                              Text(
                                "₹ " + authProvider.user.expAmt.toStringAsFixed(2),
                                style: TextStyle(fontSize: 18, color: Colors.red),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 5.0, 20, 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Balance",
                                  style: TextStyle(
                                      fontSize: 18, fontStyle: FontStyle.normal)),
                              Text(
                                "₹ " + (authProvider.user.income - authProvider.user.expAmt).toStringAsFixed(2),
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),


              Container(
                color: Colors.white,
                height: 350,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 15),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Category-wise Expenses: ",
                          style: GoogleFonts.openSans(
                              textStyle: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ),


                        Consumer<ExpenseProvider>(builder: (context, provider, child) {
                          if (provider.isChartLoading) {
                            return CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.green),
                            );
                          } else {
                            return AspectRatio(
                              aspectRatio: 1.7,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),

                                child: BarChart(
                                  BarChartData(
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: 5000,
                                    barTouchData: BarTouchData(
                                      enabled: false,
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.transparent,
                                        tooltipPadding: const EdgeInsets.all(0),
                                        tooltipBottomMargin: 8,
                                        getTooltipItem: (BarChartGroupData group,
                                            int groupIndex,
                                            BarChartRodData rod,
                                            int rodIndex,) {
                                          return BarTooltipItem(
                                            rod.y.round().toString(),
                                            TextStyle(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    titlesData: FlTitlesData(
                                      show: true,

                                      bottomTitles: SideTitles(
                                        showTitles: true,
                                        textStyle: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                        margin: 20,
                                        getTitles: (double value) {
                                          switch (value.toInt()) {
                                            case 0:
                                              return 'Travel';
                                            case 1:
                                              return 'Grocery';
                                            case 2:
                                              return 'Medicine';
                                            case 3:
                                              return 'Household';
                                            case 4:
                                              return 'Misc';
                                              //case 5:
                                              //return 'St';
                                              //case 6:
                                              return 'Sn';
                                            default:
                                              return '';
                                          }
                                        },
                                      ),
                                      leftTitles: SideTitles(showTitles: false,
                                          margin: 10),
                                    ),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    barGroups: [
                                      BarChartGroupData(
                                          x: 0,
                                          barRods: [
                                            BarChartRodData(y: provider.chart.totalTransport, color: Colors
                                                .cyan)
                                          ],
                                          showingTooltipIndicators: [0]),
                                      BarChartGroupData(x: 1, barRods: [
                                        BarChartRodData(y: provider.chart.totalGrocery, color: const Color(
                                            0xff19bfff))
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 2, barRods: [
                                        BarChartRodData(y: provider.chart.totalMedical, color: const Color(
                                            0xff2bdb90))
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 3, barRods: [
                                        BarChartRodData(y: provider.chart.totalHousehold, color: const Color(
                                            0xffffdd80))
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      BarChartGroupData(x: 4, barRods: [
                                        BarChartRodData(y: provider.chart.totalMisc, color: const Color(
                                            0xffff4d94))
                                      ], showingTooltipIndicators: [
                                        0
                                      ]),
                                      //BarChartGroupData(x: 3, barRods: [
                                      //BarChartRodData(y: 10, color: Colors.lightBlueAccent)
                                      //], showingTooltipIndicators: [
                                      //0
                                      //]),
                                    ],
                                  ),
                                ),
                              ),
                            );
                        }
                        }
                        )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
