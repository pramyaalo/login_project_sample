class FundWalletBalanceModel {
  final int CustomerId;
  final int Balance;
  final String TransactionPassword;

  FundWalletBalanceModel({
    required this.CustomerId,
    required this.Balance,
    required this.TransactionPassword,
  });

  factory FundWalletBalanceModel.fromJson(Map<String, dynamic> json) {
    return FundWalletBalanceModel(
      CustomerId: json['CustomerId'] as int,
      Balance: json['Balance'] as int,
      TransactionPassword: json['TransactionPassword'] as String,
    );
  }
}
