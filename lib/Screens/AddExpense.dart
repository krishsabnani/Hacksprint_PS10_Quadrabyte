import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hacksprintps10quadrabyte/Models/expense_model.dart';
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    "Travel expenses",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(

                    onChanged: (val){
                      expenseModel.transport = double.parse(val);
                      print(expenseModel.transport);
                    },
                    controller: _trasport,
                    decoration: InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: "Enter expense",
                    ),
                  )
                ],
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
                child: Center(
                  child: Text(
                    "Groceries",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    onChanged: (val){
                      expenseModel.grocery = double.parse(val);
                    },
                    controller: _grocery,
                    decoration: InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: "Enter expense",
                    ),
                  )
                ],
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
                child: Center(
                  child: Text(
                    "Medicine",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    onSaved: (val){
                      expenseModel.medical = double.parse(val);
                    },
                    controller: _medical,
                    decoration: InputDecoration(
                      //border: OutlineInputBorder(),
                      labelText: "Enter expense",
                    ),
                  )
                ],
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
                child: Center(
                  child: Text(
                    "Household",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
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
                child: Center(
                  child: Text(
                    "Misc",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
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

                    await Firestore.instance.collection('Expense').document(uid).collection("Dates")
                        .document(date)
                        .setData(expenseModel.toJson())
                        .catchError((e) async{
                      print(e);
                    });

                    await authProvider.alterData(expenseModel);

                    Navigator.pop(context);
                  }, child: Center(child: Text("Submit",
                style: TextStyle(fontSize: 20, color: Colors.white) , ))),
            )
          ],
        ),
      )
    ]))]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Add your expenses",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
            icon: Icon(Icons.arrow_back, size: 20, color: Colors.black87,)),

      ),
      body: mainbody,
      backgroundColor: Colors.white,
    );
  }
}
