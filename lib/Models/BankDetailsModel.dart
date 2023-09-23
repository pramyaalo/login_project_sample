class BankDetailsModel {
  String AccountName;
  String AccountNumber;
  String AccountType;
  String BankName;
  String Branch;
  String CustomerID;
  String BankCode;
  String Username;

  BankDetailsModel({
    required this.AccountName,
    required this.AccountNumber,
    required this.AccountType,
    required this.BankName,
    required this.Branch,
    required this.CustomerID,
    required this.BankCode,
    required this.Username,
  });

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      AccountName: json['AccountName'],
      AccountNumber: json['AccountNumber'],
      AccountType: json['AccountType'],
      BankName: json['BankName'],
      Branch: json['Branch'],
      CustomerID: json['CustomerID'],
      BankCode: json['BankCode'],
      Username: json['Username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccountName': AccountName,
      'AccountNumber': AccountNumber,
      'AccountType': AccountType,
      'BankName': BankName,
      'Branch': Branch,
      'CustomerID': CustomerID,
      'BankCode': BankCode,
      'Username': Username,
    };
  }
}
