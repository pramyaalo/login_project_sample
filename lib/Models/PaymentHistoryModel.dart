class PaymentHistoryModel {
  final String SlNo;
  final String Id;
  final String Credit;
  final String Debit;
  final String Balance;
  final String Type;
  final String CustomerName;
  final String username;
  final String Datecreated;
  final String Message;
  final String TransactionCode;
  final String Bank;
  final String AccountName;
  final String AccountNumber;
  final String BankName;
  final String Branch;
  final String Bankcode;
  final String Debit1;
  final String Credit1;

  PaymentHistoryModel(
      {required this.SlNo,
      required this.Id,
      required this.Credit,
      required this.Debit,
      required this.Balance,
      required this.Type,
      required this.CustomerName,
      required this.username,
      required this.Datecreated,
      required this.Message,
      required this.TransactionCode,
      required this.Bank,
      required this.AccountName,
      required this.AccountNumber,
      required this.BankName,
      required this.Branch,
      required this.Bankcode,
      required this.Debit1,
      required this.Credit1});

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) {
    return PaymentHistoryModel(
      SlNo: json['SlNo'].toString(),
      Id: json['Id'].toString(),
      Credit: json['Credit'].toString(),
      Debit: json['Debit'].toString(),
      Balance: json['Balance'].toString(),
      Type: json['Type'].toString(),
      CustomerName: json['CustomerName'].toString(),
      username: json['username'].toString(),
      Datecreated: json['Datecreated'].toString(),
      Message: json['Message'].toString(),
      TransactionCode: json['TransactionCode'].toString(),
      Bank: json['Bank'].toString(),
      AccountName: json['AccountName'].toString(),
      AccountNumber: json['AccountNumber'].toString(),
      BankName: json['BankName'].toString(),
      Branch: json['Branch'].toString(),
      Bankcode: json['Bankcode'].toString(),
      Debit1: json['Debit1'].toString(),
      Credit1: json['Credit1'].toString(),
    );
  }
}
