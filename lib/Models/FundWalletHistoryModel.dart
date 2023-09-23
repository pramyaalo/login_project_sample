class FundWalletHistoryModel {
  final String slNo;
  final String commisionId;
  final String Amount;
  final String stats;
  final String Type;
  final String CustomerName;
  final String username;
  final String Datecreated;
  final String Message;

  FundWalletHistoryModel({
    required this.slNo,
    required this.commisionId,
    required this.Amount,
    required this.stats,
    required this.Type,
    required this.CustomerName,
    required this.username,
    required this.Datecreated,
    required this.Message,
  });

  factory FundWalletHistoryModel.fromJson(Map<String, dynamic> json) {
    return FundWalletHistoryModel(
      slNo: json['SlNo'].toString(),
      commisionId: json['commisionid'].toString(),
      Amount: json['Amount'].toString(),
      stats: json['Stats'].toString(),
      Type: json['Type'].toString(),
      CustomerName: json['CustomerName'].toString(),
      username: json['username'].toString(),
      Datecreated: json['Datecreated'].toString(),
      Message: json['Message'].toString(),
    );
  }
}
