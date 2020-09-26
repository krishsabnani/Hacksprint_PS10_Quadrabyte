import 'package:bezier_chart/bezier_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:hacksprintps10quadrabyte/Models/chart_model.dart';
import 'package:hacksprintps10quadrabyte/Models/user_model.dart';
import 'package:intl/intl.dart';

class ExpenseProvider extends ChangeNotifier {
  List<DataPoint<DateTime>> reqGraphList = List<DataPoint<DateTime>>(7);
  ChartModel chart = ChartModel();
  bool isLoading = false;
  bool isChartLoading = false;
  ExpenseProvider(User user) {
    getRequestGraphData(user);
    getChartData(user);
  }

  getRequestGraphData(User user) async {
    isLoading = true;
    notifyListeners();

    for (int i = 0; i < 7; i++) {
      await Firestore.instance
          .collection("Expense")
          .document(user.uid)
          .collection("Dates")
          .document(DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY)
              .format(DateTime.now().subtract(Duration(days: 6 - i))))
          .get()
          .then((doc) {
        if (!(doc.exists)) {
          reqGraphList[i] = DataPoint<DateTime>(
              value: 0, xAxis: DateTime.now().subtract(Duration(days: 6 - i)));
        } else
          reqGraphList[i] = DataPoint<DateTime>(
              value: doc.data['total'].toDouble(),
              xAxis: DateTime.now().subtract(Duration(days: 6 - i)));
      }).catchError((e) {
        print(e);
//        reqGraphList.add(DataPoint<DateTime>(value: 1,
//            xAxis: DateTime.now().subtract(Duration(days: 6 - i))));
      });
    }

    isLoading = false;
    notifyListeners();
  }

  getChartData(User user) async {
    isChartLoading = true;
    await Firestore.instance
        .collection("Expense")
        .document(user.uid)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        chart = ChartModel.fromJson(snapshot.data);
        notifyListeners();
      } else {
        print("chart data error");
      }
    });
    print(chart);
    isChartLoading = false;
    notifyListeners();
  }
}
