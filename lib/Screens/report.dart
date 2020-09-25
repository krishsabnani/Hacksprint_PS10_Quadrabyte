import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Icon(Icons.report),
        title: Text(
          "User report",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(5, 2.0, 2, 2),
        child: Column(
          children: <Widget>[
            Text(
              "User details ",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: const Color(0xff81e5cd),
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text(
                      "Name",
                    ),
                    subtitle: Text("Username here"),
                  ),
                  ListTile(
                    leading: Icon(Icons.email),
                    title: Text("Email"),
                    subtitle: Text("User email here"),
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
              padding: const EdgeInsets.fromLTRB(1, 8.0, 1, 8),
              child: Container(
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  color: const Color(0xff81e5cd),
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Overview",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5.0, 20, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Income",
                              style: TextStyle(
                                  fontSize: 18, fontStyle: FontStyle.italic),
                            ),
                            Text(
                              "112",
                              style: TextStyle(fontSize: 18),
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
                                    fontSize: 18, fontStyle: FontStyle.italic)),
                            Text("112", style: TextStyle(fontSize: 18))
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
                                    fontSize: 18, fontStyle: FontStyle.italic)),
                            Text("112", style: TextStyle(fontSize: 18))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Expense chart",
                    style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            AspectRatio(
              aspectRatio: 1.7,
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color(0xff81e5cd),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 20,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBottomMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.white,
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          switch (value.toInt()) {
                            case 0:
                              return 'Travel';
                            case 1:
                              return 'Groceries';
                            case 2:
                              return 'Medicine';
                            case 3:
                              return 'Food';
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
                      leftTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: [
                      BarChartGroupData(
                          x: 0,
                          barRods: [BarChartRodData(y: 8, color: Colors.cyan)],
                          showingTooltipIndicators: [0]),
                      BarChartGroupData(x: 1, barRods: [
                        BarChartRodData(y: 10, color: const Color(0xff19bfff))
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 2, barRods: [
                        BarChartRodData(y: 14, color: const Color(0xff2bdb90))
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 3, barRods: [
                        BarChartRodData(y: 15, color: const Color(0xffffdd80))
                      ], showingTooltipIndicators: [
                        0
                      ]),
                      BarChartGroupData(x: 4, barRods: [
                        BarChartRodData(y: 13, color: const Color(0xffff4d94))
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
            ),
          ],
        ),
      ),
    );
  }
}
