class QCashWalletHistoryModel {
  final String slNo;
  final String commisionId;
  final String amount;
  final String stats;
  final String type;
  final String customerName;
  final String username;
  final String dateCreated;
  final String message;

  QCashWalletHistoryModel({
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

  factory QCashWalletHistoryModel.fromJson(Map<String, dynamic> json) {
    return QCashWalletHistoryModel(
      slNo: json['SlNo'].toString(),
      commisionId: json['commisionid'].toString(),
      amount: json['Amount'].toString(),
      stats: json['Stats'].toString(),
      type: json['Type'].toString(),
      customerName: json['CustomerName'].toString(),
      username: json['username'].toString(),
      dateCreated: json['Datecreated'].toString(),
      message: json['Message'].toString(),
    );
  }
}
