class PendingPaymentsModel {
  final String SlNo;
  final String Id;
  final String Credit;
  final String Debit;
  final String Balance;
  final String CustomerName;
  final String username;
  final String Datecreated;
  final String Message;
  final String AccountName;
  final String AccountNumber;
  final String BankName;
  final String Bankcode;
  final String Branch;
  final String Bank;
  final String Debit1;

  PendingPaymentsModel(
      {required this.SlNo,
      required this.Id,
      required this.Credit,
      required this.Debit,
      required this.Balance,
      required this.CustomerName,
      required this.username,
      required this.Datecreated,
      required this.Message,
      required this.AccountName,
      required this.AccountNumber,
      required this.BankName,
      required this.Bankcode,
      required this.Branch,
      required this.Bank,
      required this.Debit1});

  factory PendingPaymentsModel.fromJson(Map<String, dynamic> json) {
    return PendingPaymentsModel(
      SlNo: json['SlNo'].toString(),
      Id: json['Id'].toString(),
      Credit: json['Credit'].toString(),
      Debit: json['Debit'].toString(),
      Balance: json['Balance'].toString(),
      CustomerName: json['CustomerName'].toString(),
      username: json['username'].toString(),
      Datecreated: json['Datecreated'].toString(),
      Message: json['Message'].toString(),
      AccountName: json['AccountName'].toString(),
      AccountNumber: json['AccountNumber'].toString(),
      BankName: json['BankName'].toString(),
      Bankcode: json['Bankcode'].toString(),
      Branch: json['Branch'].toString(),
      Bank: json['Bank'].toString(),
      Debit1: json['Debit1'].toString(),
    );
  }
}
