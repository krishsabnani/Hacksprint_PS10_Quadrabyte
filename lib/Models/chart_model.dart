class ChartModel {
  double totalMedical;
  double totalGrocery;
  double totalHousehold;
  double totalTransport;
  double totalMisc;

  ChartModel(
      {this.totalMedical,
        this.totalGrocery,
        this.totalHousehold,
        this.totalTransport,
        this.totalMisc});

  ChartModel.fromJson(Map<String, dynamic> json) {
    totalMedical = json['totalMedical'];
    totalGrocery = json['totalGrocery'];
    totalHousehold = json['totalHousehold'];
    totalTransport = json['totalTransport'];
    totalMisc = json['totalMisc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalMedical'] = this.totalMedical;
    data['totalGrocery'] = this.totalGrocery;
    data['totalHousehold'] = this.totalHousehold;
    data['totalTransport'] = this.totalTransport;
    data['totalMisc'] = this.totalMisc;
    return data;
  }
}
