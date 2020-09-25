class User {
  String name;
  String email;
  String uid;
  double income;
  double savePercent;
  double dailyAllowed;
  double saveAmt;
  double expAmt;
  double specialEvent;

  User(
      {this.name,
        this.email,
        this.uid,
        this.income,
        this.savePercent,
        this.dailyAllowed,
        this.saveAmt,
        this.expAmt,
        this.specialEvent});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    uid = json['uid'];
    income = json['income'];
    savePercent = json['savePercent'];
    dailyAllowed = json['dailyAllowed'];
    saveAmt = json['saveAmt'];
    expAmt = json['expAmt'];
    specialEvent = json['specialEvent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['uid'] = this.uid;
    data['income'] = this.income;
    data['savePercent'] = this.savePercent;
    data['dailyAllowed'] = this.dailyAllowed;
    data['saveAmt'] = this.saveAmt;
    data['expAmt'] = this.expAmt;
    data['specialEvent'] = this.specialEvent;
    return data;
  }
}
