class WalletCashHistoryModel {
  final int slNo;
  final int commisionId;
  final String amount;
  final int stats;
  final String type;
  final String customerName;
  final String username;
  final String dateCreated;
  final String message;

  WalletCashHistoryModel({
    required this.slNo,
    required this.commisionId,
    required this.amount,
    required this.stats,
    required this.type,
    required this.customerName,
    required this.username,
    required this.dateCreated,
    required this.message,
  });

  factory WalletCashHistoryModel.fromJson(Map<String, dynamic> json) {
    return WalletCashHistoryModel(
      slNo: json['SlNo'] as int,
      commisionId: json['commisionid'] as int,
      amount: json['Amount'] as String,
      stats: json['Stats'] as int,
      type: json['Type'] as String,
      customerName: json['CustomerName'] as String,
      username: json['username'] as String,
      dateCreated: json['Datecreated'] as String,
      message: json['Message'] as String,
    );
  }
}
