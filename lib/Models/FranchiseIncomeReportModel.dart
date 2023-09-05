class FranchiseIncomeReportModel {
  final String SlNo;
  final String customerid;
  final String Username;
  final String Name;
  final String type;
  final String Amount;
  final String TDS;
  final String ServiceTax;
  final String qcash;
  final String NETAmount;
  final String stats;
  final String Datecreated;

  FranchiseIncomeReportModel(
      {required this.SlNo,
      required this.customerid,
      required this.Username,
      required this.Name,
      required this.type,
      required this.Amount,
      required this.TDS,
      required this.ServiceTax,
      required this.qcash,
      required this.NETAmount,
      required this.stats,
      required this.Datecreated});

  factory FranchiseIncomeReportModel.fromJson(Map<String, dynamic> json) {
    return FranchiseIncomeReportModel(
      SlNo: json['SlNo'].toString(),
      customerid: json['customerid'].toString(),
      Username: json['Username'].toString(),
      Name: json['Name'].toString(),
      type: json['Type'].toString(),
      Amount: json['Amount'].toString(),
      TDS: json['TDS'].toString(),
      ServiceTax: json['ServiceTax'].toString(),
      qcash: json['qcash'].toString(),
      NETAmount: json['NETAmount'].toString(),
      stats: json['stats'].toString(),
      Datecreated: json['Datecreated'].toString(),
    );
  }
}
