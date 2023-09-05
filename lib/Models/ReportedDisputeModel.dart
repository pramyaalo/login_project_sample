class ReportedDisputeModel {
  final String SlNo;
  final String DisputeId;
  final String UserId;
  final String Name;
  final String PhoneNo;
  final String DisputeRelated;
  final String OrderId;
  final String OrderAmount;
  final String OrderStatus;
  final String DisputeStatus;
  final String Date;

  ReportedDisputeModel(
      {required this.SlNo,
      required this.DisputeId,
      required this.UserId,
      required this.Name,
      required this.PhoneNo,
      required this.DisputeRelated,
      required this.OrderId,
      required this.OrderAmount,
      required this.OrderStatus,
      required this.DisputeStatus,
      required this.Date});

  factory ReportedDisputeModel.fromJson(Map<String, dynamic> json) {
    return ReportedDisputeModel(
      SlNo: json['SlNo'].toString(),
      DisputeId: json['DisputeId'].toString(),
      UserId: json['UserId'].toString(),
      Name: json['Name'].toString(),
      PhoneNo: json['PhoneNo'].toString(),
      DisputeRelated: json['DisputeRelated'].toString(),
      OrderId: json['OrderId'].toString(),
      OrderAmount: json['OrderAmount'].toString(),
      OrderStatus: json['OrderStatus'].toString(),
      DisputeStatus: json['DisputeStatus'].toString(),
      Date: json['Date'].toString(),
    );
  }
}
