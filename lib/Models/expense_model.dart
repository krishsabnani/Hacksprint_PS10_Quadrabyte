class ExpenseModel {
  double medical;
  double grocery;
  double household;
  double transport;
  double misc;
  double total;

  


  ExpenseModel(
      {this.medical,
        this.grocery,
        this.household,
        this.transport,
        this.misc,
        this.total,
      });

  ExpenseModel.fromJson(Map<String, dynamic> json) {
    medical = json['medical'];
    grocery = json['grocery'];
    household = json['household'];
    transport = json['transport'];
    misc = json['misc'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medical'] = this.medical;
    data['grocery'] = this.grocery;
    data['household'] = this.household;
    data['transport'] = this.transport;
    data['misc'] = this.misc;
    data['total'] = this.total;
    return data;
  }
}
