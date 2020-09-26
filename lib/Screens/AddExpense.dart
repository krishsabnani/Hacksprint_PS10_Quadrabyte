import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hacksprintps10quadrabyte/Models/expense_model.dart';
import 'package:hacksprintps10quadrabyte/Pages/page_host.dart';
import 'package:hacksprintps10quadrabyte/Providers/auth_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddExpense extends StatefulWidget {
  String uid;
  String date;
  AddExpense(this.uid, this.date);
  @override
  _AddExpenseState createState() => _AddExpenseState(this.uid, this.date);
}

class _AddExpenseState extends State<AddExpense> {
  String date;
  String uid;
  _AddExpenseState(this.uid, this.date);
  final _formKey = GlobalKey<FormState>();
  TextEditingController _medical;
  TextEditingController _trasport;
  TextEditingController _misc;
  TextEditingController _grocery;
  TextEditingController _household;
  ExpenseModel expenseModel = ExpenseModel();
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    print(authProvider.user.name);
    var leadingButton = RaisedButton.icon(
        //button should lead back to the dashboard
        onPressed: (){},
        icon: Icon(
          Icons.arrow_back_ios,
          size: 10,
        ),
        label: Text("hello"));
    var bgcolor = 0xff453658;
    var mainbody = ListView(
    children: <Widget>[
    Form(
      key: _formKey,
      child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
         // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Travel: ",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(right: 50),
                child: TextFormField(
                  keyboardType: TextInputType.numberWithOptions(),
                  onChanged: (val){
                    expenseModel.transport = double.parse(val);
                    print(expenseModel.transport);
                  },
                  controller: _trasport,
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: "Enter expense",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Grocery: ",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding:  EdgeInsets.only(right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      onChanged: (val){
                        expenseModel.grocery = double.parse(val);
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: _grocery,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: "Enter expense",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Medical: ",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      onSaved: (val){
                        expenseModel.medical = double.parse(val);
                      },
                      keyboardType: TextInputType.numberWithOptions(),
                      controller: _medical,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: "Enter expense",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Household: ",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (val){
                        expenseModel.household = double.parse(val);
                      },
                      controller: _household,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: "Enter expense",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Misc: ",
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.only(right: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.numberWithOptions(),
                      onChanged: (val){
                        expenseModel.misc = double.parse(val);
                      },
                      controller: _misc,
                      decoration: InputDecoration(
                        //border: OutlineInputBorder(),
                        labelText: "Enter expense",
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green,
              ),
              child: FlatButton(

                  onPressed: () async{
                    _formKey.currentState.save();
                    expenseModel.total = expenseModel.medical + expenseModel.misc + expenseModel.grocery + expenseModel.household + expenseModel.transport;
                    print(expenseModel.total);
                    print("Date :" + date);
                    await Firestore.instance.collection('Expense').document(uid).collection("Dates")
                        .document(date)
                        .setData(expenseModel.toJson())
                        .catchError((e) async{
                      print(e);
                    });

                    await Firestore.instance.collection("Expense").document(uid).updateData({
                      "totalMedical" : FieldValue.increment(expenseModel.medical),
                      "totalMisc" : FieldValue.increment(expenseModel.misc),
                      "totalGrocery" : FieldValue.increment(expenseModel.grocery),
                      "totalHousehold" : FieldValue.increment(expenseModel.household),
                      "totalTransport" : FieldValue.increment(expenseModel.medical),
                    })
                    .catchError((e) async {
                      print("create new");
                      await Firestore.instance.collection("Expense").document(uid).setData({
                        "totalMedical" : FieldValue.increment(expenseModel.medical),
                        "totalMisc" : FieldValue.increment(expenseModel.misc),
                        "totalGrocery" : FieldValue.increment(expenseModel.grocery),
                        "totalHousehold" : FieldValue.increment(expenseModel.household),
                        "totalTransport" : FieldValue.increment(expenseModel.transport),
                      });
                    });

                    await authProvider.alterData(expenseModel);

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageHost(0)));
                  }, child: Center(child: Text("Submit",
                style: TextStyle(fontSize: 20, color: Colors.white) , ))),
            )
          ],
        ),
      )
    ]))]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        //leading: backbutton,
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Add expenses for " + date,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.white,)),

      ),
      body: mainbody,
      backgroundColor: Colors.white,
    );
  }
}
