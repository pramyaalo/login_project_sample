class PayoutReportsModel {
  final String SlNo;
  final String CustomerId;
  final String UserID;
  final String Name;
  final String IncomeEarnedDate;
  final String BinaryIncome;
  final String FranchiseIncome;
  final String FranchiseReferral;
  final String TDS;
  final String ServiceTax;
  final String QCash;
  final String NetAmt;

  PayoutReportsModel(
      {required this.SlNo,
      required this.CustomerId,
      required this.UserID,
      required this.Name,
      required this.IncomeEarnedDate,
      required this.BinaryIncome,
      required this.FranchiseIncome,
      required this.FranchiseReferral,
      required this.TDS,
      required this.ServiceTax,
      required this.QCash,
      required this.NetAmt});

  factory PayoutReportsModel.fromJson(Map<String, dynamic> json) {
    return PayoutReportsModel(
      SlNo: json['SlNo'].toString(),
      CustomerId: json['CustomerId'].toString(),
      UserID: json['UserID'].toString(),
      Name: json['Name'].toString(),
      IncomeEarnedDate: json['IncomeEarnedDate'].toString(),
      BinaryIncome: json['BinaryIncome'].toString(),
      FranchiseIncome: json['FranchiseIncome'].toString(),
      FranchiseReferral: json['FranchiseReferral'].toString(),
      TDS: json['TDS'].toString(),
      ServiceTax: json['ServiceTax'].toString(),
      QCash: json['QCash'].toString(),
      NetAmt: json['NetAmt'].toString(),
    );
  }
}
