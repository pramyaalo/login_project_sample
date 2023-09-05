class BinaryIncomeReportModel {
  final String SlNo;
  final String customerid;
  final String Username;
  final String Name;
  final String Amount;
  final String TDS;
  final String ServiceTax;
  final String qcash;
  final String NETAmount;
  final String stats;
  final String Datecreated;

  BinaryIncomeReportModel(
      {required this.SlNo,
      required this.customerid,
      required this.Username,
      required this.Name,
      required this.Amount,
      required this.TDS,
      required this.ServiceTax,
      required this.qcash,
      required this.NETAmount,
      required this.stats,
      required this.Datecreated});

  factory BinaryIncomeReportModel.fromJson(Map<String, dynamic> json) {
    return BinaryIncomeReportModel(
      SlNo: json['SlNo'].toString(),
      customerid: json['customerid'].toString(),
      Username: json['Username'].toString(),
      Name: json['Name'].toString(),
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
